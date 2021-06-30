//
//  TopRatedItemCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit
import SDWebImage

final class TopRatedItemCell: UICollectionViewCell {
    
    static let identifier: String = "TopRatedItemCellIdentifier"
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func bindViewWith(movie: Movie) {
        movieTitleLabel.text = movie.title
        movieImageView.sd_setImage(with: movie.posterURL, completed: nil)
    }
    
    private func configureView() {
        contentView.addSubview(movieImageView)
        contentView.addSubview(movieTitleLabel)
        
        movieImageView.anchor(
            top: contentView.topAnchor,
            leading: contentView.leadingAnchor,
            bottom: nil,
            trailing: contentView.trailingAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: 0,
            height: 0
        )
        
        movieTitleLabel.anchor(
            top: movieImageView.bottomAnchor,
            leading: contentView.leadingAnchor,
            bottom: contentView.bottomAnchor,
            trailing: contentView.trailingAnchor,
            paddingTop: 10,
            paddingLeft: 10,
            paddingBottom: 10,
            paddingRight: 10,
            width: 0,
            height: 0
        )
        
        movieTitleLabel.setContentHuggingPriority(
            UILayoutPriority(rawValue: 252),
            for: .vertical
        )
        
        movieTitleLabel.setContentCompressionResistancePriority(
            UILayoutPriority(rawValue: 751),
            for: .vertical
        )
    }
}
