//
//  TabBarViewProtocol.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//

import UIKit

protocol TabBarViewProtocol {
    var tabIcon: UIImage? { get }
    var tabTitle: String { get }
    
    func configuredViewController() -> UIViewController
}
