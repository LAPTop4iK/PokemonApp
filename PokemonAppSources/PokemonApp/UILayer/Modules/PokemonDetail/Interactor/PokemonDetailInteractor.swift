//
//  PokemonDetailInteractor.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import Foundation

class PokemonDetailInteractor {
    weak var output: PokemonDetailInteractorOutput?
    
    var pokemonApiManager: PokemonAPI?
}

// MARK: - PokemonDetailInteractorInput
extension PokemonDetailInteractor: PokemonDetailInteractorInput {
    func getPokemonDetailFor(id: Int) async {
        Task {
            do {
                let pokemonDetails = try await pokemonApiManager?.fetchCompletePokemonInfoFor(id: id)
                output?.getPokemonDetailSuccess(model: pokemonDetails)
            } catch {
                output?.getPokemonDetailFail(error: "getPokemonDetailError")
            }
        }
    }
    

}
