//
//  UIColor+Contast.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 02/10/2023.
//

import UIKit

extension UIColor {
    var isDark: Bool {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0

        getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        let luminance = 0.299 * red + 0.587 * green + 0.114 * blue

        return luminance < 0.5
    }

    func lighter(by percentage: CGFloat = 20.0) -> UIColor? {
        return self.adjust(by: abs(percentage))
    }

    func adjust(by percentage: CGFloat = 30.0) -> UIColor? {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if self.getRed(&r, green: &g, blue: &b, alpha: &a) {
            return UIColor(red: min(r + percentage/100, 1.0),
                           green: min(g + percentage/100, 1.0),
                           blue: min(b + percentage/100, 1.0),
                           alpha: a)
        } else {
            return nil
        }
    }
}
