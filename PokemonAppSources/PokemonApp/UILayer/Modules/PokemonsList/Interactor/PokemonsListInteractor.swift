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
    
    var pokemonApiManager: PokemonAPI?
}

// MARK: - PokemonsListInteractorInput

extension PokemonsListInteractor: PokemonsListInteractorInput {

    func getPokemons(startIndex: Int, countItems: Int) async {
        do {
            let pokemonListSuccsed = try await pokemonApiManager?.fetchPokemons(limit: countItems, offset: startIndex)
            output?.getPokemonsSuccess(model: pokemonListSuccsed)
        } catch {
            debugPrint("error")
        }
    }
}
