//
//  PokemonDetailInteractor.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonDetailInteractor {
    weak var output: PokemonDetailInteractorOutput?

    var coreDataManager: DataStoreManager<DetailPokemonInfoEntity, DetailPokemonInfo>?
    var pokemonApiManager: PokemonAPI?
    var imageManager: ImageManager?
}

// MARK: - PokemonDetailInteractorInput

extension PokemonDetailInteractor: PokemonDetailInteractorInput {
    func getImageWith(url: URL) async throws -> UIImage? {
        do {
            let imageData = try await imageManager?.fetchImage(withURL: url.description)
            let imageModel = ImageModel(url: url.description, data: imageData)
            return imageModel.image
        } catch {
            return nil
        }
    }
    
    func getPokemonDetailFor(id: Int) async {
        do {
            if let localData = try await coreDataManager?.load(identifier: "\(id)") {
                output?.getPokemonDetailSuccess(model: localData)
            } else {
                if let pokemonDetails = try await pokemonApiManager?.fetchCompletePokemonInfoFor(id: id) {
                    output?.getPokemonDetailSuccess(model: pokemonDetails)

                    do {
                        try await coreDataManager?.save(model: pokemonDetails)
                    } catch {}
                } else {
                    output?.getPokemonDetailFail(error: "DataUnavailable")
                }
            }
        } catch {
            output?.getPokemonDetailFail(error: error.localizedDescription)
        }
    }
}
