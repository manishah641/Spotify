//
//  SearchResultsViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import UIKit
struct SearchSection {
    let title:String
    let results:[SearchResult]
}
protocol SearchResultsViewControllerDelegate:AnyObject {
    func didTapResult(_ result:SearchResult)
}

class SearchResultsViewController: UIViewController {
    private var sections:[SearchSection] = []
    
    weak var delegate:SearchResultsViewControllerDelegate?
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .systemBackground
        tableView.register(SearchResultDefaultTableViewCell.self, forCellReuseIdentifier: SearchResultDefaultTableViewCell.identifier)
        tableView.isHidden = true
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
 
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
    }
    
    func update(with results:[SearchResult]){
        let artists = results.filter {
            switch $0 {
            case .artist:return true
            default:return false
            }
        }
        let albums = results.filter {
            switch $0 {
            case .album:return true
            default:return false
            }
        }
        let tracks = results.filter {
            switch $0 {
            case .track:return true
            default:return false
            }
        }
        let playlists = results.filter {
            switch $0 {
            case .playlist :return true
            default:return false
            }
        }
        
        self.sections = [
            SearchSection(title: "Songs", results: tracks),
            SearchSection(title: "Artist", results: artists),
            SearchSection(title: "Playlists", results: playlists),
            SearchSection(title: "Album", results: albums)
        ]
    
         tableView.isHidden = results.isEmpty
        tableView.reloadData()
        
    
    }
    
}
//MARK: - UItableViewDelegate And dataSource

extension SearchResultsViewController :UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let result = sections[indexPath.section].results[indexPath.row]
        switch result {
        case .artist(model: let artist):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultDefaultTableViewCell.identifier,
                    for: indexPath) as? SearchResultDefaultTableViewCell else {
                return UITableViewCell()
            }
            let viewModel =  searchResultDefaultTableViewCellViewModel(
                title: artist.name,
                imageURL:URL(string: artist.images?.first?.url ?? "") )
            cell.configure(with:viewModel )
            return cell
        case .album(model: let album):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                    for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(title: album.name,
                                                                        subtitle: album.artists.first?.name ?? "",
                                                                        imageURL: URL(string: album.images.first?.url ?? ""))
            cell.configure(with:viewModel)
            return cell
        case .track(model: let track):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                    for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel =  SearchResultSubtitleTableViewCellViewModel(title: track.name,
                                                                        subtitle: track.album?.name ?? "",
                                                                        imageURL: URL(string: track.album?.images.first?.url ?? ""))
            cell.configure(with:viewModel)
            return cell
        case .playlist(model: let playlist):
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                    for: indexPath) as? SearchResultSubtitleTableViewCell else {
                return UITableViewCell()
            }
            let viewModel = SearchResultSubtitleTableViewCellViewModel(title: playlist.name,
                                                                      subtitle: playlist.owner.display_name,
                                                                      imageURL: URL(string: playlist.images.first?.url ?? ""))
            cell.configure(with: viewModel)
            return cell
        }
        
     
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let result = sections[indexPath.section].results[indexPath.row]
        self.delegate?.didTapResult(result)
    }
}
