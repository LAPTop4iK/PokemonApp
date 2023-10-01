//
//  PokemonsListInteractor.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import Foundation

class PokemonsListInteractor {
    weak var output: PokemonsListInteractorOutput?
}

// MARK: - PokemonsListInteractorInput

extension PokemonsListInteractor: PokemonsListInteractorInput {
    func getPokemons(startIndex _: Int, countItems _: Int) {
        output?.getPokemonsSuccess(model: PokemonList(count: 1, next: "", previous: "", results: [PokemonInfo]()))
    }
}
