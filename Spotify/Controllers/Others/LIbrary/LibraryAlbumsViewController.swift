//
//  LibraryAlbumsViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 22/09/2021.
//

import UIKit

class LibraryAlbumsViewController: UIViewController {
    
    var albums = [Album]()
    private let noAlbumView = ActionLabelView()
    
    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        
        tableView.isHidden = true
        return tableView
    }()
    private var observer:NSObjectProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate  = self
        tableView.dataSource  = self
        
        setUpNoAlbumView()
        fetchData()
     
        NotificationCenter.default.addObserver(
            forName: .albumSavedNotification,
            object: nil,
            queue: .main) {[weak self] _ in
                self?.fetchData()
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noAlbumView.frame = CGRect(x: (view.width-150)/2, y: (view.height-150)/2, width: 150, height: 150)
//        noAlbumView.center = view.center
        tableView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
        
    }
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateUI(){
        if albums.isEmpty {
            noAlbumView.isHidden = false
            tableView.isHidden = true
        }else {
            tableView.reloadData()
            tableView.isHidden = false
            noAlbumView.isHidden = true
            
        }
    }
    private func setUpNoAlbumView(){
        view.addSubview(noAlbumView)
        noAlbumView.configure(with: ActionLabelViewViewModel(text: "You Have not saved Any Album Yet",
                                                                 actionTitle: "Browse"))
        noAlbumView.delegate = self
    }
    fileprivate func fetchData() {
        albums.removeAll()
        APICaller.shared.getCurrentUserAlbums {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let album):
                    self?.albums = album
                    self?.updateUI()
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
}
extension LibraryAlbumsViewController:ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        tabBarController?.selectedIndex = 0
    }
    

    
    
}
//MARK: - UITableView DataSource And Delegate

extension LibraryAlbumsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                                                       for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let album = albums[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
            title: album.name,
            subtitle: album.artists.first?.name ?? "",
            imageURL: URL(string: album.images.first?.url ?? ""))
        )
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManagers.shared.vibrateForSelection()
        let album = albums[indexPath.row]
        
        let vc = AlbumViewController(album: album)
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
