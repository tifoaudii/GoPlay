//
//  TopRatedMovieCollectionCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit

final class TopRatedMovieCollectionCell: UITableViewCell, Animationable {
    
    // MARK:- Static Cell Identifier
    
    static let identifier: String = "TopRatedMovieCollectionCellIdentifier"
    
    // MARK:- UI Components
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 0, left: 12, bottom: 0, right: 6)
        collectionView.register(TopRatedItemCell.self, forCellWithReuseIdentifier: TopRatedItemCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alpha = 0.0
        return collectionView
    }()

    // MARK:- Initializer & Overriden functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topRatedMovies.removeAll()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    // MARK:- Private data
    
    private var topRatedMovies: [Movie] = []
    
    // MARK:- Internal functions
    
    func addMovies(movies: [Movie]) {
        topRatedMovies.append(contentsOf: movies)
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

extension TopRatedMovieCollectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedItemCell.identifier, for: indexPath) as? TopRatedItemCell else {
            return UICollectionViewCell()
        }
        
        cell.bindViewWith(movie: topRatedMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return topRatedMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: 120, height: 200)
    }
}
