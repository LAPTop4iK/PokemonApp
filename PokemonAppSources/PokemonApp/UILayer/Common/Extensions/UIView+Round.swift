//
//  UIView+Round.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import UIKit

extension UIView {
    func circle() {
        roundView(frame.height / 2)
    }

    func roundView(_ radius: CGFloat) {
        layer.cornerRadius = radius
    }
}
