//
//  PokemonsListRouter.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonsListRouter {}

// MARK: - PokemonsListRouterInput

extension PokemonsListRouter: PokemonsListRouterInput {
    func showPokemonDetailFor(id: Int, from viewController: UIViewController) {
        PokemonDetailModule(id: id).present(from: viewController)
    }
}
