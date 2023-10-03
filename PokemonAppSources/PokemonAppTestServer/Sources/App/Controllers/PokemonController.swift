//
//  File.swift
//  
//
//  Created by Mikita Laptsionak on 02/10/2023.
//

import Vapor

struct PokemonController: RouteCollection {
    
    func boot(routes: RoutesBuilder) throws {
        let pokemonsRoute = routes.grouped("pokemons")
        pokemonsRoute.get(use: getAllHandler)
    }

    func getAllHandler(_ req: Request) async throws -> [PokemonDetail] {
        let apiUrl = "https://pokeapi.co/api/v2/pokemon"
        
        // Получаем параметры пагинации
        let limit: Int = req.query["limit"] ?? 20
        let offset: Int = req.query["offset"] ?? 0
        
        let client = req.client
        let pokemonListResponse = try await client.get(URI(string: "\(apiUrl)?limit=\(limit)&offset=\(offset)"))
        let pokemons = try pokemonListResponse.content.decode(PokemonList.self)
        
        var pokemonDetails: [PokemonDetail] = []
        for pokemon in pokemons.results {
            let pokemonDetailResponse = try await client.get(URI(string: pokemon.url))
            let pokemonDetail = try pokemonDetailResponse.content.decode(PokemonDetail.self)
            pokemonDetails.append(pokemonDetail)
        }
        return pokemonDetails
    }
}
