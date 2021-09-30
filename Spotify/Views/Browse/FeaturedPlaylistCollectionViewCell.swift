//
//  FeaturedPlaylistCollectionViewCell.swift
//  Spotify
//
//  Created by Syed Muhammad on 13/09/2021.
//

import UIKit

class FeaturedPlaylistCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeaturedPlaylistCollectionViewCell"
    
    private let playListCoverImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 4
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let playListNameLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let creatorNameLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
       contentView.addSubview(playListCoverImageView)
        contentView.addSubview(playListNameLabel)
        contentView.clipsToBounds = true
        contentView.addSubview(creatorNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height-70
        playListCoverImageView.frame = CGRect(x: (contentView.width-imageSize)/2,
                                              y: 3,
                                              width: imageSize,
                                              height: imageSize
        )
        playListNameLabel.frame = CGRect(x: 3,
                                         y: contentView.height-60,
                                         width: contentView.width-6,
                                         height: 30)
        creatorNameLabel.frame = CGRect(x: 3,
                                        y: contentView.height-30,
                                        width: contentView.width-6,
                                        height: 30)
        
        
        
//        let imageSize:CGFloat = contentView.height-10
//        let albumLabelsize =  playListNameLabel.sizeThatFits(
//            CGSize(width: contentView.width-imageSize-10,
//                   height: contentView.height-10)
//        )
//        creatorNameLabel.sizeToFit()
//
//
//        playListCoverImageView.frame = CGRect(x: 5,
//                                           y: 5,
//                                           width: imageSize,
//                                           height: imageSize)
//        let albumNameHeight = min(60, albumLabelsize.height)
//        playListNameLabel.frame = CGRect(x: playListCoverImageView.right+10,
//                                      y: 5,
//                                      width: albumLabelsize.width,
//                                      height:albumNameHeight
//        )
//
//
//        creatorNameLabel.frame = CGRect(x: playListCoverImageView.right+10,
//                                           y: contentView.bottom-44,
//                                           width: creatorNameLabel.width,
//                                           height: 44)
//
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        playListNameLabel.text = nil
        creatorNameLabel.text = nil
        playListCoverImageView.image = nil
    }
    
    func configure(with viewModel:FeaturePlaylistcellViewModel){
        playListNameLabel.text = viewModel.name
        creatorNameLabel.text = "Tracks : \(viewModel.creatorName)"
        playListCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
