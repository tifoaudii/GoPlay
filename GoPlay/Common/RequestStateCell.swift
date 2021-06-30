//
//  RequestStateCell.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit
import NVActivityIndicatorView

final class RequestStateCell: UITableViewCell {
    
    static let identifier: String = "RequestStateCellIdentifier"
    
    private lazy var spinner: NVActivityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .ballPulseSync, color: .red)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
    }
    
    private func configureCell() {
        selectionStyle = .none
        let mainScreen: CGRect = UIScreen.main.bounds
        let activityIndicatorSize: CGSize = CGSize(width: 40, height: 40)
        
        contentView.addSubview(spinner)
        spinner.frame = CGRect(
            origin: CGPoint(
                x: (mainScreen.width / 2) - (activityIndicatorSize.width / 2),
                y: (mainScreen.height / 2) - 120
            ),
            size: activityIndicatorSize
        )
        
        spinner.startAnimating()
        
    }
}
