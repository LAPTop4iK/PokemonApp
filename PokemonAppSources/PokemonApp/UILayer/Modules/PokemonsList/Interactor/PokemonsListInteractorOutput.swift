//
//  PokemonsListInteractorOutput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import Foundation

protocol PokemonsListInteractorOutput: AnyObject {
    func getPokemonsSuccess(model: PokemonList)
    func getPokemonsFail(error: String)
}
