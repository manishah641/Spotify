//
//  RecommendedTracksCollectionViewCell.swift
//  Spotify
//
//  Created by Syed Muhammad on 13/09/2021.
//

import UIKit

class RecommendedTracksCollectionViewCell: UICollectionViewCell {
    static let identifier = "RecommendedTracksCollectionViewCell"
    
    private let albumCoverImageView : UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private let trackNameLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
     
        return label
    }()
    private let artistNameLabel:UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .thin)
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubview(albumCoverImageView)
        contentView.addSubview(trackNameLabel)
        contentView.clipsToBounds = true
        contentView.addSubview(artistNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let imageSize = contentView.height-4
        albumCoverImageView.frame = CGRect(x:5,
                                           y: 2,
                                           width: imageSize,
                                           height: imageSize)
        trackNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                       y: 0,
                                       width: contentView.width-albumCoverImageView.right-15,
                                       height: contentView.height/2)
        
        artistNameLabel.frame = CGRect(x: albumCoverImageView.right+10,
                                       y: contentView.height/2,
                                       width: contentView.width-albumCoverImageView.right-15,
                                       height: contentView.height/2)
 
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        trackNameLabel.text = nil
        artistNameLabel.text = nil
        albumCoverImageView.image = nil
    }
    
    func configure(with viewModel:RecommedeTrackCellViewModel){
        trackNameLabel.text = viewModel.name
        artistNameLabel.text = "Tracks : \(viewModel.artistName)"
        albumCoverImageView.sd_setImage(with: viewModel.artworkURL, completed: nil)
    }
}
