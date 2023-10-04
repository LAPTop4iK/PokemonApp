//
//  TypeOfPower.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import UIKit

enum TypeOfPower: String, CaseIterable {
    case wind
    case ice
    case ghost
    case normal
    case flying
    case bug
    case electric
    case fairy
    case ground
    case poison
    case psychic
    case water
    case rock
    case dragon
    case fighting
    case steel
    case grass
    case dark
    case fire
    
    var color: UIColor {
        return UIColor(named: self.rawValue) ?? UIColor.systemBackground
    }
    
    var image: UIImage? {
        return UIImage(named: self.rawValue)
    }
}
