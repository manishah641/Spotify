//
//  SearchResultSubtitleTableViewCell.swift
//  Spotify
//
//  Created by Syed Muhammad on 22/09/2021.
//
import UIKit
import SDWebImage

class SearchResultSubtitleTableViewCell: UITableViewCell {
static let identifier = "SearchResultSubtitleTableViewCell"
    
    private let label:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        return label
        
    }()
    private let subtitleLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .secondaryLabel
        return label
        
    }()
    private let iconImageView:UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(iconImageView)
        contentView.addSubview(label)
        contentView.addSubview(subtitleLabel)
        contentView.clipsToBounds = true
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.image = nil
        label.text = nil
        subtitleLabel.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize:CGFloat = contentView.height-10
        let labelSize:CGFloat = contentView.height/2
        iconImageView.frame = CGRect(x: 10,
                                     y: 5,
                                     width: imageSize,
                                     height: imageSize)
        label.frame = CGRect(x: iconImageView.right+10 ,
                             y: 0,
                             width: contentView.width-iconImageView.right-15,
                             height: labelSize)
        subtitleLabel.frame = CGRect(x: iconImageView.right+10,
                                     y: label.bottom,
                                     width: contentView.width-iconImageView.right-15,
                                     height: labelSize)
     

    }
    func configure(with viewModel:SearchResultSubtitleTableViewCellViewModel){
        label.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        iconImageView.sd_setImage(with: viewModel.imageURL,placeholderImage: UIImage(systemName: "photo") ,completed: nil)
    }
}
