//
//  SearchView.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 01/07/21.
//

import UIKit

final class SearchView: UIView {
    
    // MARK:- Callback Closure
    var onSearch: ((_ text: String) -> Void)?
    
    // MARK:- UI Components
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search Movies..."
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.layer.cornerRadius = 12.0
        button.addTarget(self, action: #selector(self.searchButtonDidTapped), for: .touchUpInside)
        return button
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
    
    // MARK:- Private Functions
    
    private func configureView() {
        let stackView = UIStackView(
            arrangedSubviews: [
                textField ,
                searchButton
            ]
        )
        .setAxis(.horizontal)
        .setSpacing(16)
        .setDistribution(.fillProportionally)
        .setMargins(16)
        
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    @objc private func searchButtonDidTapped() {
        endEditing(true)
        onSearch?(textField.text ?? "")
    }
}
