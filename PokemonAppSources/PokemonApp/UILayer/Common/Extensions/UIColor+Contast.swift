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
}
