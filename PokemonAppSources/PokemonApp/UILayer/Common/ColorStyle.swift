//
//  ColorStyle.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

enum ColorStyle {

    func style() -> (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        switch self {
        }
    }
    
    func color() -> UIColor {
        return UIColor(self)
    }
}

extension UIColor {
    convenience init(_ colorStyle: ColorStyle) {
        let (red, green, blue, alpha) = colorStyle.style()
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
