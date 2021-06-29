//
//  MainAppViewController.swift
//  GoPlay
//
//  Created by Tifo Audi Alif Putra on 29/06/21.
//

import UIKit

final class MainAppViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
    }
}

extension MainAppViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        true
    }
}
