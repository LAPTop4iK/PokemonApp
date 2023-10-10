//
//  ListPokemonApiModel.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import Foundation

struct ListPokemonModel {
    var count: Int
    var next: String?
    var previous: String?
    var details: [PokemonDetail]

    mutating func updatePageWith(model: ListPokemonModel) {
        count = model.count
        next = model.next
        previous = model.previous
        details.append(contentsOf: model.details)
    }
}

struct PokemonDetail: NetworkResponse {
    let id: Int
    let name: String
    let imageUrl: String?
    let types: [TypeOfPower]

    private struct RawPokemonDetail: Codable {
        let id: Int
        let name: String
        let sprites: Sprites
        let types: [TypeElement]

        struct Sprites: Codable {
            let front_default: String
        }
    }

    init(
        id: Int,
        name: String,
        imageUrl: String?,
        types: [TypeOfPower]
    ) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.types = types
    }

    // Инициализатор, который преобразует RawPokemonDetail в PokemonDetail
    init(from decoder: Decoder) throws {
        let rawDetail = try RawPokemonDetail(from: decoder)

        id = rawDetail.id
        name = rawDetail.name
        imageUrl = rawDetail.sprites.front_default

        // Маппим [TypeElement] к [TypeOfPower]
        types = rawDetail.types.compactMap { TypeOfPower(rawValue: $0.type.name) }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(imageUrl, forKey: .imageUrl)
    }

    enum CodingKeys: String, CodingKey {
        case id, name, imageUrl = "sprites", types
    }
}

// MARK: - Nested Structs

struct PokemonList: NetworkResponse {
    var count: Int
    var next: String
    var previous: String?
    var results: [Pokemon]

    mutating func updatePageWith(model: PokemonList) {
        count = model.count
        next = model.next
        previous = model.previous
        results.append(contentsOf: model.results)
    }
}

struct TypeElement: Codable {
    let type: TypeInfo
}

struct TypeInfo: Codable {
    let name: String
}

struct Pokemon: NetworkResponse {
    let name: String?
    let url: String?
}
