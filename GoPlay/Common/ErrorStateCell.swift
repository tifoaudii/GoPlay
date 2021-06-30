//
//  ErrorStateCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit

final class ErrorStateCell: UITableViewCell {
    
    static let identifier = "ErrorStateCellIdentifier"
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "Ooops, Something went wrong"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var desc: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Please try again"
        label.textAlignment = .center
        return label
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Retry", for: .normal)
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.heightAnchor.constraint(equalToConstant: 45).isActive = true
        button.widthAnchor.constraint(equalToConstant: 180).isActive = true
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(self.buttonDidTap), for: .touchUpInside)
        return button
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [title, desc, reloadButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16
        stackView.distribution = .fill
        return stackView
    }()
    
    var onReload: (() -> Void)?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func configureCell() {
        selectionStyle = .none
        contentView.addSubview(stackView)
        stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -80.0).isActive = true
        stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    @objc private func buttonDidTap() {
        onReload?()
    }
}
