//
//  PokemonList.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

// MARK: - PokemonList

struct PokemonList: Codable {
    var count: Int
    var next: String
    var previous: String?
    var results: [PokemonInfo]

    mutating func updatePageWith(model: PokemonList) {
        count = model.count
        next = model.next
        previous = model.previous
        results.append(contentsOf: model.results)
    }
}

// MARK: - Result

struct PokemonInfo: Codable {
    let name: String
    let url: String
}
