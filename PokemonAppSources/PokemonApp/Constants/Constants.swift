//
//  Constants.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

enum Constants {
    enum Devices {
        static let iPad = UIDevice.current.userInterfaceIdiom == .pad
        static let iPhone = UIDevice.current.userInterfaceIdiom == .phone
    }
    
    enum ViewTag {
        static let loader = 50
    }
}
