//
//  FontStyle.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 02/10/2023.
//

import UIKit

enum FontStyle {
    case title1
    case header1
    case text1
    case text2
    case description

    case semibold(CGFloat)
    case regular(CGFloat)
    case medium(CGFloat)

    enum FontType: String {
        case displayMedium = "SFProDisplay-Medium"
        case displayRegular = "SFProDisplay-Regular"
        case displayLight = "SFProDisplay-Light"
        case displayRegularItalic = "SFProDisplay-Italic"
        case displaySemibold = "SFProDisplay-Semibold"
    }

    func style() -> (String, CGFloat) {
        switch self {
        case .title1:
            return (FontType.displaySemibold.rawValue, 25)
        case .header1:
            return (FontType.displaySemibold.rawValue, 17)
        case .text1:
            return (FontType.displayMedium.rawValue, 15)
        case .text2:
            return (FontType.displayRegular.rawValue, 21)
        case .description:
            return (FontType.displayRegular.rawValue, 18)
        case let .semibold(size):
            return (FontType.displaySemibold.rawValue, size)
        case let .regular(size):
            return (FontType.displayRegular.rawValue, size)
        case let .medium(size):
            return (FontType.displayMedium.rawValue, size)
        }
    }

    func font() -> UIFont {
        return UIFont(self)
    }
}
