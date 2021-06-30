//
//  NowPlayingMovieItemCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit

final class NowPlayingMovieItemCell: UICollectionViewCell {
    
    static let identifier: String = "NowPlayingMovieItemCellIdentifier"
    
    private lazy var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4.0
        imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        return imageView
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
        movieImageView.sd_setImage(with: movie.posterURL, completed: nil)
    }
    
    private func configureView() {
        contentView.addSubview(movieImageView)
        movieImageView.fillSuperview()
    }
}
