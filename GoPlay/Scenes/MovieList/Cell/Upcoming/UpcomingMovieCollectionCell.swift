//
//  UpcomingMovieCollectionCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit

final class UpcomingMovieCollectionCell: UITableViewCell, Animationable {
    
    // MARK:- Static Cell Identifier
    
    static let identifier: String = "UpcomingMovieCollectionCellIdentifier"
    
    // MARK:- UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 6, left: 6, bottom: 6, right: 6)
        collectionView.register(UpcomingMovieItemCell.self, forCellWithReuseIdentifier: UpcomingMovieItemCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alpha = 0.0
        return collectionView
    }()
    
    // MARK:- Private data
    
    private var upcomingMovies: [Movie] = []
    
    // MARK:- Initializer & Overriden functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    // MARK:- Internal functions
    
    func addMovies(movies: [Movie]) {
        upcomingMovies = movies
        collectionView.reloadData()
    }
    
    // MARK:- Private functions
    
    private func configureCell() {
        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
        performAlphaAnimation(view: collectionView)
    }
}

// MARK:- UICollectionViewDelegateFlowLayout & UICollectionViewDataSource Implementation

extension UpcomingMovieCollectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingMovieItemCell.identifier, for: indexPath) as? UpcomingMovieItemCell else {
            return UICollectionViewCell()
        }
        
        cell.bindViewWith(movie: upcomingMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width - 16, height: collectionView.bounds.height / 3 - 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
}
