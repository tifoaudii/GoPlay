//
//  Animationable.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 30/06/21.
//

import UIKit

protocol Animationable {
    func performAlphaAnimation(view: UIView)
}

extension Animationable where Self: UITableViewCell {
    func performAlphaAnimation(view: UIView) {
        UIView.animate(withDuration: 0.4) { [weak view] in
            view?.alpha = 1.0
        }
    }
}
