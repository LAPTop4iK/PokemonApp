//
//  PokemonDetailViewOutput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonDetailViewOutput: AnyObject {
    func viewIsReady()
    func tapNavigationLeftBarButton()
}
