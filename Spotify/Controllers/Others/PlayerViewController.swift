//
//  PlayerViewController.swift
//  Spotify
//
//  Created by Syed Muhammad on 09/09/2021.
//  index error



import UIKit
import SDWebImage
protocol PlayerViewControllerDelegate:AnyObject {
    func didTapPlayPause()
    func didTapForward()
    func didTapBack()
    func didSlideSlider(value:Float)
}

class PlayerViewController: UIViewController {
    
    weak var dataSource:PlayerDataSource?
    weak var delegate:PlayerViewControllerDelegate?
    private let imageView:UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    private let controllView = PlayerControllerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        view.addSubview(controllView)
        controllView.delegate  = self
        configureBArButton()
        configure()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(x: 0,
                                 y: view.safeAreaInsets.top,
                                 width: view.width,
                                 height: view.width)
        controllView.frame = CGRect(x: 10,
                                    y: imageView.bottom+10,
                                    width: view.width-20,
                                    height: view.height-imageView.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-15)
    }
    
    private func configureBArButton(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close,
                                                           target: self,
                                                           action: #selector(didTapClose))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                           target: self,
                                                           action: #selector(didTapAction))
    }
    func configure(){
        imageView.sd_setImage(with: dataSource?.imageURL, completed: nil)
        controllView.configure(with: PlayerControllerViewViewModel(
                                title: dataSource?.songName,
                                subtitle: dataSource?.subtitle)
        )
    }
    
    @objc private func didTapClose(){
        dismiss(animated: true, completion: nil)
        
    }
    @objc private func didTapAction(){
//        actions
    }
    func refreshUI(){
        configure()
    }
    
}
extension PlayerViewController:PlayerControllerViewDelegate{
    func playerControllerView(_ playerControllerView: PlayerControllerView, didSlideSlider value: Float) {
        delegate?.didSlideSlider(value: value)
    }
    
    func playerControllerViewDidTapPlayPauseButton(_ playerControllerView: PlayerControllerView) {
        delegate?.didTapPlayPause()
    }
    
    func playerControllerViewDidTapForwardButton(_ playerControllerView: PlayerControllerView) {
        delegate?.didTapForward()
    }
    
    func playerControllerViewDidTapBackwardsButton(_ playerControllerView: PlayerControllerView) {
        delegate?.didTapBack()
    }
    
    
}
