//
//  UpcomingMovieItemCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit

final class UpcomingMovieItemCell: UICollectionViewCell {
    
    // MARK:- Static Cell Identifier
    static let identifier: String = "UpcomingMovieItemCellIdentifier"
    
    // MARK:- UI Components
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        return imageView
    }()
    
    private lazy var movieTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var movieDescLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK:- Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    // MARK:- Internal functions
    
    func bindViewWith(movie: Movie) {
        movieImageView.sd_setImage(with: movie.posterURL, completed: nil)
        movieTitleLabel.text = movie.title
        movieDescLabel.text = movie.overview
    }
    
    // MARK:- Private functions
    
    private func configureView() {
        let stackView = UIStackView(
            arrangedSubviews: [
                movieImageView,
                UIStackView(arrangedSubviews: [
                    movieTitleLabel,
                    movieDescLabel
                ])
                .setAxis(.vertical)
                .setAlignment(.top)
                .setSpacing(6)
            ]
        )
        .setAxis(.horizontal)
        .setSpacing(12)
        .setMargins(10)
        
        movieTitleLabel.setContentHuggingPriority(
            UILayoutPriority(rawValue: 252),
            for: .vertical
        )
        
        movieTitleLabel.setContentCompressionResistancePriority(
            UILayoutPriority(rawValue: 751),
            for: .vertical
        )
        
        contentView.addSubview(stackView)
        stackView.fillSuperview()
    }
}
