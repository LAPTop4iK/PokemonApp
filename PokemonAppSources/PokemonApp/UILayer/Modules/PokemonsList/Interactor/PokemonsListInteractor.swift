//
//  PokemonsListInteractor.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonsListInteractor {
    weak var output: PokemonsListInteractorOutput?

    var coreDataManager: DataStoreManager<ListPokemonEntity, PokemonDetail>?
    var pokemonApiManager: PokemonAPI?
    var imageManager: ImageManager?
}

// MARK: - PokemonsListInteractorInput

extension PokemonsListInteractor: PokemonsListInteractorInput {
    func getImageWith(url: URL) async throws -> UIImage? {
        do {
            let imageData = try await imageManager?.fetchImage(withURL: url.description)
            let imageModel = ImageModel(url: url.description, data: imageData)
            return imageModel.image
        } catch {
            return nil
        }
    }
    
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

                await output?.getPokemonsSuccess(model: response)
            } else {
                let pokemons = try await pokemonApiManager?.fetchPokemons(limit: countItems, offset: startIndex)
                await output?.getPokemonsSuccess(model: pokemons)
                if let pokemons {
                    try await coreDataManager?.save(models: pokemons.details)
                }
            }
        } catch {
            output?.getPokemonsFail(error: error.localizedDescription)
        }
    }
}
