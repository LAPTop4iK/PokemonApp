//
//  PokemonsListInteractorInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonsListInteractorInput: AnyObject {
    var output: PokemonsListInteractorOutput? { get set }

    func getPokemons(startIndex: Int, countItems: Int) async throws
    func getImageWith(url: URL) async throws -> UIImage?
}
