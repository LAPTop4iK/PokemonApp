//
//  UIFont+Style.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 02/10/2023.
//

import UIKit

extension UIFont {
    convenience init(_ fontStyle: FontStyle) {
        let (name, size) = fontStyle.style()
        // swiftlint:disable force_unwrapping
        self.init(name: name, size: size)!
        // swiftlint:enable force_unwrapping
    }
}
