//
//  SearchViewInput.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import Foundation

protocol SearchViewInput {
    func clearSearch()
    func disableSearch()
    func setPlaceholder(_ text: String)
}
