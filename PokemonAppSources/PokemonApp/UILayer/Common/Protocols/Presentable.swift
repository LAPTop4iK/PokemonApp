//
//  Presentable.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

protocol Presentable {
    var viewController: UIViewController { get }
}

extension Presentable where Self: UIViewController {
    var viewController: UIViewController {
        return self
    }
    
    func present(from viewController: UIViewController, animated: Bool) {
        self.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(self, animated: true)
    }
    
    func presentAsNavController(from viewController: UIViewController, animated: Bool) {
        let navigationController = UINavigationController(rootViewController: self)
        navigationController.modalPresentationStyle = .fullScreen
        viewController.present(navigationController, animated: true, completion: nil)
    }
}
