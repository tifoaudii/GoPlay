//
//  NowPlayingMovieCollectionCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit

final class NowPlayingMovieCollectionCell: UITableViewCell {

    static let identifier: String = "NowPlayingMovieCollectionCellIdentifier"
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.contentInset = .init(top: 6, left: 10, bottom: 6, right: 6)
        collectionView.register(NowPlayingMovieItemCell.self, forCellWithReuseIdentifier: NowPlayingMovieItemCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private var nowPlayingMovies: [Movie] = []
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    func addMovies(movies: [Movie]) {
        nowPlayingMovies = movies
        collectionView.reloadData()
    }
    
    private func configureCell() {
        contentView.addSubview(collectionView)
        collectionView.fillSuperview()
    }
}

extension NowPlayingMovieCollectionCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingMovieItemCell.identifier, for: indexPath) as? NowPlayingMovieItemCell else {
            return UICollectionViewCell()
        }
        
        cell.bindViewWith(movie: nowPlayingMovies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        .init(width: collectionView.bounds.width / 2 + 18, height: collectionView.bounds.height - 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
}
