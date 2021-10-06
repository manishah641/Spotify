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
        btn.setTitleColor(.black, for: .normal)
        
        return btn
    }()
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "albums_background")
        return imageView
    }()
    private let logoImageView:UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "startupImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let label : UILabel  = {
       let label = UILabel()
        label.numberOfLines  = 0
        label.textColor = .white
        label.textAlignment  = .center
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.text = "Listen to Million\nof Songs\nthe go."
        return label
    }()
    
    private let overlayView : UIView = {
       let view  = UIView()
        view.backgroundColor = .black
        view.alpha = 0.7
        return view
    }()
//MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Spotify"
        view.addSubview(imageView)
        view.addSubview(overlayView)
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
        view.addSubview(label)
        view.addSubview(logoImageView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = view.bounds
        overlayView.frame = view.bounds
        signInButton.frame = CGRect(x: 20, y: view.height-50-view.safeAreaInsets.bottom, width: view.width-40 , height: 50)
        logoImageView.frame = CGRect(x: (view.width-120)/2, y: (view.height-350)/2, width: 120, height: 120)
        label.frame = CGRect(x: 30, y: logoImageView.bottom+30, width: view.width-60, height: 150)
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
