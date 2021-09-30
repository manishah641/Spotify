//
//  ProfileViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import UIKit
import SDWebImage
class ProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    private var models = [String]()
    
    private let tableView:UITableView = {
       let tv = UITableView()
        tv.isHidden  = true
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
      title = "Profile"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        fetchProfile()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func fetchProfile(){
        APICaller.shared.getcurrentUserProfile {[weak self] result in
            DispatchQueue.main.async {
           
                switch result {
                case .success(let model):
                    self?.updateUI(with : model)
                case.failure(let error):
                    print("Profile error : \(error.localizedDescription)")
                    self?.failedToGetProfile()
                }
            }
      
        }

    }
    private func updateUI(with model:UserProfile){
        tableView.isHidden = false
        models.append("FULL Name: \(model.display_name)")
        models.append("FULL Email: \(model.email)")
        models.append("user id: \(model.id)")
        models.append("plan: \(model.product)")
        createTableHeader(with : model.images.first?.url)
        tableView.reloadData()
        
    }
    private func createTableHeader(with string:String?){
        guard let urlString = string,let url = URL(string: urlString) else {
            return
        }
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.width/1.5))
        let imageSize:CGFloat = headerView.height/2
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize, height: imageSize))
        headerView.addSubview(imageView)
        imageView.center = headerView.center
        imageView.contentMode = .scaleAspectFill
        imageView.sd_setImage(with: url, completed: nil)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageSize/2
        
        tableView.tableHeaderView = headerView
        
    }
    private func failedToGetProfile(){
        let label = UILabel(frame: .zero)
        label.text = "Failed to load profile"
        label.sizeToFit()
        label.textColor  = .secondaryLabel
        view.addSubview(label)
        label.center = view.center
        
    }

}
//MARK: - TableViewDataSource
extension ProfileViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        models.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row]
        cell.selectionStyle  = .none
        return cell
    }
    
}
