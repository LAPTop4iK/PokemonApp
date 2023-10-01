//
//  UIView+.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }

    func addSubviews(_ views: UIView...) {
        views.forEach { view in
            self.addSubview(view)
        }
    }
}
