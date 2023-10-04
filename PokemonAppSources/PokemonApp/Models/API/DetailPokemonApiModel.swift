//
//  DetailPokemonApiModel.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//
import UIKit

struct CompletePokemonInfo {
    let detail: PokemonDetailModel
    let species: PokemonSpecies
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
    
    struct Ability: Codable {
        let ability: NameAndUrl
    }
    
    struct NameAndUrl: Codable {
        let name: String
        let url: String
    }
    
    struct Sprites: Codable {
        let other: Other
        
        struct Other: Codable {
            let officialArtwork: OfficialArtwork
            
            enum CodingKeys: String, CodingKey {
                case officialArtwork = "official-artwork"
            }
            
            struct OfficialArtwork: Codable {
                let frontDefault: String?
                
                enum CodingKeys: String, CodingKey {
                    case frontDefault = "front_default"
                }
            }
        }
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
            
        self.id = rawDetail.id
        self.name = rawDetail.name
        self.sprites = rawDetail.sprites
        self.weight = rawDetail.weight
        self.height = rawDetail.height
        self.abilities = rawDetail.abilities
            
        self.types = rawDetail.types.compactMap { TypeOfPower(rawValue: $0.type.name) }
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
    
    struct FlavorTextEntry: Codable {
        let flavorText: String
        let language: Language
        
        enum CodingKeys: String, CodingKey {
            case flavorText = "flavor_text"
            case language
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case flavorTextEntries = "flavor_text_entries"
    }
    
    struct Language: Codable {
        let name: String
    }
}
