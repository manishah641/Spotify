//
//  ViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import UIKit
enum BrowseSectionType{
    case newReleases(viewModels:[NewReleasesCellViewModel])
    case featuredPlaylists(viewModels:[FeaturePlaylistcellViewModel])
    case recomendrdTracks(viewModels:[RecommedeTrackCellViewModel])
    
    var title:String {
        switch self {
        case .newReleases:
            return "New Released Albums"
        case .featuredPlaylists:
            return "Featured Playlists"
        case .recomendrdTracks:
            return "Recommended Tracks"
        }
    }
}

class HomeViewController: UIViewController {
    //MARK: - properties
    
    private var sections = [BrowseSectionType]()
    private var newAlbums:[Album] = []
    private var playlist:[Playlist] = []
    private var  tracks:[AudioTrack] = []
    
    
    
    private var collectionView:UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewCompositionalLayout { sectionIndex, _ -> NSCollectionLayoutSection? in
            return HomeViewController.createSectionLayout(section: sectionIndex)
        }
    )
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .label
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Browes"
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .done, target: self, action: #selector(didtapSetting))
     
        configureCollectionView()
        view.addSubview(spinner)
        fetchData()
        addLongTapGesture()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        
    }
    //MARK: - Selectors
    @objc func didtapSetting(){
        let vc = SettingsViewController()
        vc.title = "settings"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func didLongPress(_ gesture:UILongPressGestureRecognizer){
        guard gesture.state == .began else {
            return
        }
        let touchPoint = gesture.location(in: collectionView)
        guard let indexPath = collectionView.indexPathForItem(at: touchPoint),
        indexPath.section == 2 else {
            return
        }
        let model = tracks[indexPath.row]
        
        let actionSheet = UIAlertController(
            title: model.name,
            message: "Would you like to add to a playlist?",
            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Add to playlist", style: .default, handler: {[weak self] _ in
            DispatchQueue.main.async {
                let vc = LibraryPlaylistsViewController()
                vc.selectionHandler = { playlist in
                    APICaller.shared.addTrackToPlaylist(track: model, playlist: playlist) { success in
                        print("Added to play list \(success)")
                    }
                }
                vc.title = "Select Playlist"
                self?.present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
            }
      
        }))
    present(actionSheet, animated: true, completion: nil)
    }
    
    //MARK: - HelpingFunctions
    private func addLongTapGesture(){
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress))
        collectionView.addGestureRecognizer(gesture)
    }
    
    
    
    private func configureCollectionView(){
        view.addSubview(collectionView)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: "cell")
        collectionView.register(NewReleaseCollectionViewCell.self,
                                forCellWithReuseIdentifier: NewReleaseCollectionViewCell.identifier)
        collectionView.register(FeaturedPlaylistCollectionViewCell.self,
                                forCellWithReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier)
        collectionView.register(RecommendedTracksCollectionViewCell.self,
                                forCellWithReuseIdentifier: RecommendedTracksCollectionViewCell.identifier)
        collectionView.register(TitleHeaderCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: TitleHeaderCollectionReusableView.identifier)
        collectionView.dataSource = self
        collectionView.delegate  = self
        collectionView.backgroundColor  = .systemBackground
        
        
    }

    
    func fetchData(){
        let group = DispatchGroup()
        group.enter()
        group.enter()
        group.enter()
        var newReleases: NewReleasesReponces?
        var featuredPlaylist:FeaturedPlaylistResponce?
        var recommendations:RecommendationsResponce?
        
        //        New Releases
        APICaller.shared.getNewRealases { result in
            defer{
                group.leave()
            }
            switch result{
            case.success(let model):
                newReleases = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        //        featured Playlist,
        APICaller.shared.getFeaturedPlaylist { result in
            defer{
                group.leave()
            }
            switch result{
            case.success(let model):
                featuredPlaylist = model
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        //        Recomended tracks,
        APICaller.shared.getRecomendedGenres { result in
            switch result {
            case .success(let model):
                let genres = model.genres
                var seeds = Set<String>()
                while seeds.count < 5 {
                    if let random = genres.randomElement(){
                        seeds.insert(random)
                    }
                }
                APICaller.shared.getRecomandations(genres: seeds) { recommendedResult in
                    defer{
                        group.leave()
                    }
                    switch recommendedResult{
                    case.success(let model):
                        recommendations = model
                    case.failure(let error):
                        print(error.localizedDescription)
                    }
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        group.notify(queue: .main) {
            guard let newAlbums = newReleases?.albums.items ,
                  let playlist = featuredPlaylist?.playlists.items,
                  let tracks = recommendations?.tracks else {return}
            self.configureModels(
                newAlbums: newAlbums,
                playlist: playlist,
                tracks: tracks)
            
        }
        
//        configure Modls
 
    }
  
    
    private func configureModels(
        newAlbums:[Album],
        playlist:[Playlist],
        tracks:[AudioTrack]
    ){
        self.newAlbums = newAlbums
        self.playlist = playlist
        self.tracks = tracks
    
        sections.append(.newReleases(viewModels: newAlbums.compactMap({
            return NewReleasesCellViewModel(name: $0.name,
                                            artWorkURL: URL(string: $0.images.first?.url ?? ""),
                                            numberOfTracks: $0.total_tracks,
                                            ArtistName: $0.artists.first?.name ?? "-")
        })))
        sections.append(.featuredPlaylists(viewModels: playlist.compactMap({
            return FeaturePlaylistcellViewModel(name: $0.name,
                                                artworkURL: URL(string: $0.images.first?.url ?? ""),
                                                creatorName: $0.owner.display_name)
        })))
        sections.append(.recomendrdTracks(viewModels: tracks.compactMap({
            return RecommedeTrackCellViewModel(name: $0.name,
                                               artistName: $0.artists.first?.name ?? "",
                                               artworkURL:URL(string: $0.album?.images.first?.url ?? "")
            )
        })))
        collectionView.reloadData()
    }

    
    
}
//MARK: - UICollectionViewDelegate UICollectionViewDataSource

extension HomeViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: false)
        HapticsManagers.shared.vibrateForSelection()
        let section = sections[indexPath.section]
        switch section {
    
        case .newReleases:
            let album = newAlbums[indexPath.row]
            let vc = AlbumViewController(album: album)
            vc.title = album.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .featuredPlaylists:
            let playlist = playlist[indexPath.row]
            let vc = PlaylistViewController(playlist: playlist)
            vc.title = playlist.name
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .recomendrdTracks:
            let track = tracks[indexPath.row]
            PlayBackPresenter.shared.startPlayback(from: self, track: track)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let type = sections[section]
        switch type {
       
        case .newReleases(let viewModels):
            return viewModels.count
        case .featuredPlaylists(let viewModels):
            return viewModels.count
        case .recomendrdTracks(let viewModels):
            return viewModels.count
        }
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let type = sections[indexPath.section]
        switch type {
        case .newReleases(let viewModels):
          guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: NewReleaseCollectionViewCell.identifier,
                for: indexPath) as? NewReleaseCollectionViewCell else {
            return UICollectionViewCell()
          }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)
            return cell

        case .featuredPlaylists(let viewModels):
            guard  let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: FeaturedPlaylistCollectionViewCell.identifier,
                      for: indexPath) as? FeaturedPlaylistCollectionViewCell else {
              return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)

              return cell
        case .recomendrdTracks(let viewModels):
            guard  let cell = collectionView.dequeueReusableCell(
                  withReuseIdentifier: RecommendedTracksCollectionViewCell.identifier,
                      for: indexPath) as? RecommendedTracksCollectionViewCell else {
              return UICollectionViewCell()
            }
            let viewModel = viewModels[indexPath.row]
            cell.configure(with: viewModel)

              return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
      guard let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: TitleHeaderCollectionReusableView.identifier,
            for: indexPath
      ) as? TitleHeaderCollectionReusableView, kind == UICollectionView.elementKindSectionHeader else  {
        return UICollectionReusableView()
      }
        let section = indexPath.section
        let title = sections[section].title
        header.configure(with: title)
        return header
    }
     static func createSectionLayout(section:Int) -> NSCollectionLayoutSection {
        //        item
        let supplementaryView = [
            NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)),
                elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        ]
        switch section {
        case 0:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets =  NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //       Vertical Group in horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)),
                subitem: item,
                count: 3)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.9),
                    heightDimension: .absolute(390)),
                subitem: verticalGroup,
                count: 1)
            //        section
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .groupPaging
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        case 1:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(200)
                )
            )
            item.contentInsets =  NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //       Vertical Group in horizontal group
            let verticalGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(400)),
                subitem: item,
                count: 2)
            
            let horizontalGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(200),
                    heightDimension: .absolute(400)),
                subitem: verticalGroup,
                count: 1)
            //        section
            
            let section = NSCollectionLayoutSection(group: horizontalGroup)
            section.orthogonalScrollingBehavior = .continuous
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        case 2:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets =  NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            //       Vertical Group in horizontal group
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(80)),
                subitem: item,
                count: 1)
            //        section
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryView
            return section
            
        default:
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            item.contentInsets =  NSDirectionalEdgeInsets(top: 2, leading: 2, bottom: 2, trailing: 2)
            let group = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(390)),
                subitem: item,
                count: 1
            )
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = supplementaryView
            return section
        }
    }
    
}

