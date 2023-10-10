//
//  Pokemon.swift
//
//
//  Created by Mikita Laptsionak on 02/10/2023.
//

import Vapor

struct Pokemon: Content {
    let name: String
    let url: String
}

struct PokemonDetail: Content {
    let id: Int
    let name: String
    let sprites: Sprites
    let types: [TypeElement]

    struct Sprites: Content {
        let front_default: String
    }

    struct TypeElement: Content {
        let type: `Type`
    }

    struct `Type`: Content {
        let name: String
    }
}

struct PokemonList: Content {
    var results: [Pokemon]
}
