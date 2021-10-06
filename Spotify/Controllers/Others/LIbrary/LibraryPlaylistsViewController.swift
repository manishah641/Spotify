//
//  LibraryPlaylistsViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 22/09/2021.
//

import UIKit

class LibraryPlaylistsViewController: UIViewController {
    
    var playlists = [Playlist]()
    private let noPlaylistsView = ActionLabelView()
    public var selectionHandler:((Playlist)-> Void)?

    private let tableView:UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(SearchResultSubtitleTableViewCell.self, forCellReuseIdentifier: SearchResultSubtitleTableViewCell.identifier)
        
        tableView.isHidden = true
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate  = self
        tableView.dataSource  = self
      
        setUpNoPlaylistView()
        fetchData()
        if selectionHandler != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
        }
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        noPlaylistsView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        noPlaylistsView.center = view.center
        tableView.frame = view.bounds
        
    }
    @objc func didTapClose() {
        dismiss(animated: true, completion: nil)
    }
    
    private func updateUI(){
        if playlists.isEmpty {
            noPlaylistsView.isHidden = false
            tableView.isHidden = true
        }else {
            tableView.reloadData()
            tableView.isHidden = false
            noPlaylistsView.isHidden = true
            
        }
    }
    private func setUpNoPlaylistView(){
        view.addSubview(noPlaylistsView)
        noPlaylistsView.configure(with: ActionLabelViewViewModel(text: "You Don't Have Any Playlist Yet",
                                                                 actionTitle: "Create"))
        noPlaylistsView.delegate = self
    }
    fileprivate func fetchData() {
        APICaller.shared.getCurrentUserPlaylist {[weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let playlist):
                    self?.playlists = playlist
                    self?.updateUI()
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

}
extension LibraryPlaylistsViewController:ActionLabelViewDelegate {
    func actionLabelViewDidTapButton(_ actionView: ActionLabelView) {
        showCreatePlaylistAlert()
    }
    
    public func showCreatePlaylistAlert() {
        let alert = UIAlertController(title: "New Playlist",
                                     message: "Enter Playlist name",
                                     preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Playlist.."
            
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "Create", style: .default,handler: { _ in
            guard let field = alert.textFields?.first,
                  let text = field.text,
                  !text.trimmingCharacters(in: .whitespaces).isEmpty else {
                      return
                  }
            APICaller.shared.createPlaylist(with: text) { [weak self]success in
                if success{
                    HapticsManagers.shared.vibrate(for: .success)
                    self?.fetchData()
                }else {
                    HapticsManagers.shared.vibrate(for: .error)
                    print("Failed to create playlist")
                }
            }
        }))
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
//MARK: - UITableView DataSource And Delegate

extension LibraryPlaylistsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultSubtitleTableViewCell.identifier,
                                                       for: indexPath) as? SearchResultSubtitleTableViewCell else {
            return UITableViewCell()
        }
        let playlist = playlists[indexPath.row]
        cell.configure(with: SearchResultSubtitleTableViewCellViewModel(
            title: playlist.name,
            subtitle: playlist.owner.display_name,
            imageURL: URL(string: playlist.images.first?.url ?? ""))
        )
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        HapticsManagers.shared.vibrateForSelection()
        let playlist = playlists[indexPath.row]
        guard  selectionHandler == nil else {
            selectionHandler?(playlist)
            dismiss(animated: true)
            return
        }

      
        let vc = PlaylistViewController(playlist: playlist)
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.isOwner = true
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
