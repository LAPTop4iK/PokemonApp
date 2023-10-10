//
//  DetailPokemonApiModel.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//
import UIKit

struct DetailPokemonInfo {
    let name: String
    let id: Int
    let weight: Int
    let height: Int
    let types: [TypeOfPower]
    let imageUrl: String?
    let flavorText: String?

    var mainColor: UIColor? {
        types.first?.color
    }
}

struct PokemonDetailModel: NetworkResponse {
    let name: String
    let id: Int
    let weight: Int
    let height: Int
    let abilities: [Ability]
    let types: [TypeOfPower]
    let sprites: Sprites

    var mainColor: UIColor {
        types.first?.color ?? .systemYellow
    }

    private struct RawPokemonDetailModel: Codable {
        let name: String
        let id: Int
        let weight: Int
        let height: Int
        let abilities: [Ability]
        let sprites: Sprites
        let types: [TypeElement]
    }

    // Инициализатор, который преобразует RawPokemonDetail в PokemonDetail
    init(from decoder: Decoder) throws {
        let rawDetail = try RawPokemonDetailModel(from: decoder)

        id = rawDetail.id
        name = rawDetail.name
        sprites = rawDetail.sprites
        weight = rawDetail.weight
        height = rawDetail.height
        abilities = rawDetail.abilities

        types = rawDetail.types.compactMap { TypeOfPower(rawValue: $0.type.name) }
    }

    init(
        name: String,
        id: Int,
        weight: Int,
        height: Int,
        abilities: [Ability],
        types: [TypeOfPower],
        sprites: Sprites
    ) {
        self.name = name
        self.id = id
        self.weight = weight
        self.height = height
        self.abilities = abilities
        self.types = types
        self.sprites = sprites
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(sprites, forKey: .sprites)
    }

    enum CodingKeys: String, CodingKey {
        case id, name, sprites, types,
             weight, height, abilities
    }
}

struct PokemonSpecies: NetworkResponse {
    let flavorTextEntries: [FlavorTextEntry]

    var firstEnglishFlavorText: String? {
        return flavorTextEntries.first(where: { $0.language.name == "en" })?.flavorText.withoutNewlines
    }

    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
}

struct Ability: Codable {
    let ability: NameAndUrl
}

struct NameAndUrl: Codable {
    let name: String
    let url: String
}

struct Sprites: Codable {
    let other: Other
}

struct FlavorTextEntry: Codable {
    let flavorText: String
    let language: Language

    enum CodingKeys: String, CodingKey {
        case flavorText = "flavor_text"
        case language
    }
}

struct Language: Codable {
    let name: String
}

struct Other: Codable {
    let officialArtwork: OfficialArtwork

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

struct OfficialArtwork: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
