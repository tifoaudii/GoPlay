//
//  ViewMessages.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit
import SwiftMessages

protocol ViewMessages: AnyObject {
    func showMessage(message: String)
}

extension ViewMessages where Self: UIViewController {
    func showMessage(message: String) {
        let baseView = createBaseMessageView(message: message)
        SwiftMessages.show(view: baseView)
    }
    
    private func createBaseMessageView(message: String) -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: 60).isActive = true
        view.backgroundColor = .red
        
        let headerLabel = UILabel()
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerLabel.text = message
        headerLabel.font = .systemFont(ofSize: 16, weight: .heavy)
        headerLabel.textColor = .white
        
        view.addSubview(headerLabel)
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }
}
