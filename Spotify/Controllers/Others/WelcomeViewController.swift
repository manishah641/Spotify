//
//  WelcomeViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//

import UIKit

class WelcomeViewController: UIViewController {
    //MARK: - properties
    
     
    private let signInButton:UIButton = {
       let btn = UIButton()
        btn.backgroundColor = .systemGray
        btn.setTitle("Sign In with Spotify", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        
        return btn
    }()
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.backgroundColor = .systemGreen
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        signInButton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40 , height: 50)
    }
    //MARK: - Selectors
    
    @objc func didTapSignIn(){
        let vc = AuthViewController()
        vc.complitionHanlder = {[weak self] success in
            DispatchQueue.main.async {
                self?.handleSignin(sucess: success)
            }
            
            
        }
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    //MARK: - Helping function

    private func handleSignin(sucess:Bool){
        guard sucess else {
            let alert =  UIAlertController(title: "oopss", message: "Something Went Wrong when Signing In.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dissmiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        let mainAppTabBarvc = TabBarViewController()
        mainAppTabBarvc.modalPresentationStyle = .fullScreen
        present(mainAppTabBarvc, animated: true, completion: nil)
    }

}
