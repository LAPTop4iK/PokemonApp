//
//  PokemonApiModel.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import Foundation

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

struct PokemonDetail: NetworkResponse {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeOfPower]

    struct Sprites: Codable {
        let front_default: String
    }

    private struct RawPokemonDetail: Codable {
        let id: Int
        let name: String
        let sprites: Sprites
        let types: [TypeElement]
    }

    // Инициализатор, который преобразует RawPokemonDetail в PokemonDetail
    init(from decoder: Decoder) throws {
        let rawDetail = try RawPokemonDetail(from: decoder)

        self.id = rawDetail.id
        self.name = rawDetail.name
        self.sprites = rawDetail.sprites

        // Маппим [TypeElement] к [TypeOfPower]
        self.types = rawDetail.types.compactMap { TypeOfPower(rawValue: $0.type.name) }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sprites, forKey: .sprites)
    }

    enum CodingKeys: String, CodingKey {
        case id, name, sprites, types
    }
}

struct PokemonAPIResponse {
    var count: Int
    var next: String?
    var previous: String?
    var details: [PokemonDetail]

    mutating func updatePageWith(model: PokemonAPIResponse) {
        count = model.count
        next = model.next
        previous = model.previous
        details.append(contentsOf: model.details)
    }
}
