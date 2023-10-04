//
//  PokemonsListInteractorInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import Foundation

protocol PokemonsListInteractorInput: AnyObject {
    var output: PokemonsListInteractorOutput? { get set }

    func getPokemons(startIndex: Int, countItems: Int) async throws
}
