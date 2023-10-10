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

    var coreDataManager: DataStoreManager<ListPokemonEntity, PokemonDetail>?
    var pokemonApiManager: PokemonAPI?
}

// MARK: - PokemonsListInteractorInput

extension PokemonsListInteractor: PokemonsListInteractorInput {
    func getPokemons(startIndex: Int, countItems: Int) async {
        do {
            if let cachedData = try await coreDataManager?.load(offset: startIndex, limit: countItems),
               !cachedData.isEmpty {
                let response = ListPokemonModel(
                    count: cachedData.count,
                    next: nil,
                    previous: nil,
                    details: cachedData
                )

                output?.getPokemonsSuccess(model: response)
            } else {
                let pokemons = try await pokemonApiManager?.fetchPokemons(limit: countItems, offset: startIndex)
                output?.getPokemonsSuccess(model: pokemons)
                if let pokemons {
                    try await coreDataManager?.save(models: pokemons.details)
                }
            }
        } catch {
            debugPrint("Error: \(error.localizedDescription)")
        }
    }
}
