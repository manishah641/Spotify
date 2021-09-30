//
//  PlayerControllerView.swift
//  Spotify
//
//  Created by Syed Muhammad on 22/09/2021.
//

import UIKit

protocol PlayerControllerViewDelegate:AnyObject {
    func playerControllerViewDidTapPlayPauseButton(_ playerControllerView:PlayerControllerView)
    func playerControllerViewDidTapForwardButton(_ playerControllerView:PlayerControllerView)
    func playerControllerViewDidTapBackwardsButton(_ playerControllerView:PlayerControllerView)
    func playerControllerView(_ playerControllerView:PlayerControllerView,didSlideSlider value:Float)
}

final class PlayerControllerView: UIView {
    private var isPlaying = true
    
    weak var delegate:PlayerControllerViewDelegate?
    
    private let volumeSlider:UISlider  = {
       let slider = UISlider()
        slider.value = 0.5
        return slider
    }()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text  = "This is my songs"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let subtitleLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text  = "Drake (feat. Some Other Artists)"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let backButton:UIButton  = {
       let button=UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "backward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,
                                                                                                       weight: .regular))
     
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let nextButton:UIButton  = {
       let button=UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "forward.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,
                                                                                                       weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    private let playPauseButton:UIButton  = {
       let button=UIButton()
        button.tintColor = .label
        let image = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,
                                                                                                       weight: .regular))
        button.setImage(image, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(subtitleLabel)

        addSubview(volumeSlider)
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_:)), for:.valueChanged )
        
        addSubview(backButton)
        addSubview(nextButton)
        addSubview(playPauseButton)
        
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.frame  = CGRect(x: 0, y: 0, width: width, height: 50)
        subtitleLabel.frame  = CGRect(x: 0, y: nameLabel.bottom+10, width: width, height: 50)
        volumeSlider.frame  = CGRect(x: 10, y: subtitleLabel.bottom+20, width: width-20, height:44)
        let buttonSize:CGFloat  = 60
        playPauseButton.frame  = CGRect(x: (width-buttonSize)/2,
                                        y: volumeSlider.bottom+30,
                                        width: buttonSize,
                                        height:buttonSize)
        backButton.frame  = CGRect(x: playPauseButton.left-80-buttonSize,
                                   y: playPauseButton.top,
                                   width: buttonSize,
                                   height:buttonSize)
        nextButton.frame  = CGRect(x: playPauseButton.right+80,
                                   y: playPauseButton.top,
                                   width: buttonSize,
                                   height:buttonSize)
    }
    //MARK: - Selectors
    @objc func didSlideSlider(_ slider:UISlider){
        let value = slider.value
        delegate?.playerControllerView(self, didSlideSlider: value)
    }
    
    @objc func didTapBack() {
        delegate?.playerControllerViewDidTapBackwardsButton(self)
    }
    @objc func didTapNext() {
        delegate?.playerControllerViewDidTapForwardButton(self)
    }
    @objc func didTapPlayPause() {
        self.isPlaying = !isPlaying
        delegate?.playerControllerViewDidTapPlayPauseButton(self)
        let play = UIImage(systemName: "play.fill",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,
                                                                                              weight: .regular))
        let pause  = UIImage(systemName: "pause",withConfiguration: UIImage.SymbolConfiguration(pointSize: 34,
                                                                                               weight: .regular))
        playPauseButton.setImage(isPlaying ? pause : play, for: .normal)
    }
    func configure(with viewModel:PlayerControllerViewViewModel){
        nameLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }

}
