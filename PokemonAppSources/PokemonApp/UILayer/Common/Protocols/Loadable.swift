//
//  Loadable.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

protocol Loadable {
    func showLoader()
    func showLoader(constantY: CGFloat)
    func showRootViewLoader()
    func hideRootViewLoader()
    func hideLoader()

    func showAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)?)
    func showAlert(msg: String)
}

extension Loadable where Self: UIViewController {
    func showLoader() {
        showLoader(constantY: 0)
    }
    
    func showLoader(constantY: CGFloat) {
        self.view.showRotationLoader(constantY: constantY)
    }
    
    func showRootViewLoader() {
        self.view.showRootViewLoader()
    }

    func hideRootViewLoader() {
        self.view.hideRootViewLoader()
    }
    
    func hideLoader() {
        self.view.hideRotationLoader()
    }
    
    func showAlert(msg: String) {
        showAlert(title: "Error", msg: msg) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    func showAlert(title: String, msg: String, handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        if let view = alertController.view {
            view.accessibilityIdentifier = "System alert"
        }
        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: handler)
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
}
