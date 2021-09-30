//
//  ActionLabelView.swift
//  Spotify
//
//  Created by Syed Muhammad on 23/09/2021.
//

import UIKit
import SafariServices

 protocol ActionLabelViewDelegate:AnyObject {
    func actionLabelViewDidTapButton(_ actionView:ActionLabelView)
}



struct ActionLabelViewViewModel {
    let text : String
    let actionTitle :String
}
class ActionLabelView: UIView {
    
    weak var delegate:ActionLabelViewDelegate?

    private let label : UILabel  = {
       let label = UILabel()
        label.textAlignment = .center
        label.textColor  = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private let button :UIButton = {
       let button = UIButton()
        button.setTitleColor(.link, for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubview(label)
        addSubview(button)
        isHidden = true
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        button.frame  = CGRect(x: 0,
                               y: height-40,
                               width: width, height: 40)
        label.frame = CGRect(x: 0,
                             y: 0,
                             width: width,
                             height: height-45)
    }
    func configure(with viewModel:ActionLabelViewViewModel){
        label.text  = viewModel.text
        button.setTitle(viewModel.actionTitle, for: .normal)
    }
    
    @objc func didTapButton(){
        delegate?.actionLabelViewDidTapButton(self)
    }
}
