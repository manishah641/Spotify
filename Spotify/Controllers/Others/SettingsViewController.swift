//
//  SettingsViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    private var sections = [Section]()
    
    private let tableView : UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        configureModels()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    private func configureModels(){
        sections.append(Section(title: "Profile", option: [Option(title: "View Your Profile", handler: {[weak self ] in
            DispatchQueue.main.async {
                self?.viewProfile()
            }
        })]))
        sections.append(Section(title: "Account", option: [Option(title: "Sign Out", handler: {[weak self ] in
            DispatchQueue.main.async {
                self?.SignOutTapped()
            }
        })]))
    }
    private func viewProfile(){
        let vc = ProfileViewController()
        vc.title = "Profile"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    private func SignOutTapped(){
        
    }

    
}
//MARK: - UItableView delegate And DataSource
extension SettingsViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].option.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = sections[indexPath.section].option[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = sections[indexPath.section].option[indexPath.row]
        model.handler()
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = sections[section]
        return model.title
    }
    
    
}
