//
//  PokemonDetailInteractorInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonDetailInteractorInput: AnyObject {
    var output: PokemonDetailInteractorOutput? { get set }

    func getPokemonDetailFor(id: Int) async throws
    func getImageWith(url: URL) async throws -> UIImage?
}
