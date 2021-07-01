//
//  EmptyStateCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

import UIKit

final class EmptyStateCell: UITableViewCell {

    static let identifier = "EmptyStateCellIdentifier"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "No sign of search"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var desc: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Sorry, we couldn't find what you're looking for. Anything else you would like to watch?"
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCell() {
        selectionStyle = .none
        let stackView = UIStackView(
            arrangedSubviews: [
                title,
                desc
            ]
        )
        .setAxis(.vertical)
        .setSpacing(16)
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -32),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -90),
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
}
