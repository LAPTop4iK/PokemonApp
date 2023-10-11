//
//  PokemonsListInteractorOutput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

protocol PokemonsListInteractorOutput: AnyObject {
    func getPokemonsSuccess(model: ListPokemonModel?)
    func getPokemonsFail(error: String)
}
