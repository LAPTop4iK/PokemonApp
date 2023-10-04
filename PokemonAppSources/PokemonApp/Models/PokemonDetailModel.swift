//
//  PokemonDetailModel.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//

// MARK: - PokemonList
struct PokemonDetailModel: Codable {
    let id: Int
    let types: [TypeElement]
    let name: String
    let sprites: Sprites
}

// MARK: - Sprites
struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - TypeElement
struct TypeElement: Codable {
    let type: TypeType
}

// MARK: - TypeType
struct TypeType: Codable {
    let name: String
}
