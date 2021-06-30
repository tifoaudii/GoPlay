//
//  TopRatedMovieCollectionCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit

final class TopRatedMovieCollectionCell: UITableViewCell, Animationable {
    
    static let identifier: String = "TopRatedMovieCollectionCellIdentifier"
    
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        topRatedMovies.removeAll()
    }
    
    private var topRatedMovies: [Movie] = []
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    func addMovies(movies: [Movie]) {
        topRatedMovies.append(contentsOf: movies)
        collectionView.reloadData()
    }
    
    private func configureCell() {
        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
        performAlphaAnimation(view: collectionView)
    }
}

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
