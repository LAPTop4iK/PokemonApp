//
//  NetworkManager+PokemonApi.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//
import Foundation

class PokemonAPI {
    let networkManager = NetworkManager()
    let baseURL = "https://pokeapi.co/api/v2/"

    // Method to fetch Pokemons with Details using above two methods
    func fetchPokemons(limit: Int, offset: Int) async throws -> ListPokemonModel {
        // Fetch the Pokemon List
        let pokemonList = try await fetchPokemonsList(limit: limit, offset: offset)

        // Fetch Details of each Pokemon
        let details = try await fetchPokemonDetails(from: pokemonList)

        return ListPokemonModel(
            count: pokemonList.count,
            next: pokemonList.next,
            previous: pokemonList.previous,
            details: details.sorted { $0.id < $1.id }
        )
    }

    func fetchCompletePokemonInfoFor(id: Int) async throws -> DetailPokemonInfo {
        let pokemonDetail = try await fetchPokemonDetail(id: id)
        let pokemonSpecies = try await fetchPokemonSpecies(id: id)

        let completePokemonInfo = DetailPokemonInfo(
            name: pokemonDetail.name,
            id: pokemonDetail.id,
            weight: pokemonDetail.weight,
            height: pokemonDetail.height,
            types: pokemonDetail.types,
            imageUrl: pokemonDetail.sprites.other.officialArtwork.frontDefault,
            flavorText: pokemonSpecies.firstEnglishFlavorText
        )
        return completePokemonInfo
    }
}

private extension PokemonAPI {
    // First Method: Fetch Pokemon List
    func fetchPokemonsList(limit: Int, offset: Int) async throws -> PokemonList {
        let urlString = "\(baseURL)pokemon?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let request = NetworkRequest<PokemonList>(method: .get, url: url)
        let pokemonList = try await networkManager.getNetworkResponse(request)
        return pokemonList
    }

    // Second Method: Fetch Details of each Pokemon in List
    func fetchPokemonDetails(from pokemonList: PokemonList) async throws -> [PokemonDetail] {
        var pokemonDetails: [PokemonDetail] = []

        try await withThrowingTaskGroup(of: PokemonDetail.self) { group in
            for pokemon in pokemonList.results {
                group.addTask {
                    guard let pokemonDetailUrl = URL(string: pokemon.url ?? "") else {
                        throw URLError(.badURL)
                    }
                    let pokemonDetailRequest = NetworkRequest<PokemonDetail>(method: .get, url: pokemonDetailUrl)
                    let detail = try await self.networkManager.getNetworkResponse(pokemonDetailRequest)
                    debugPrint("Detail fetched for: \(pokemon.name ?? "unknown")")
                    return detail
                }
            }

            for try await detail in group {
                pokemonDetails.append(detail)
                debugPrint("Aggregating detail...")
            }
        }
        return pokemonDetails
    }

    func fetchPokemonDetail(id: Int) async throws -> PokemonDetailModel {
        let urlString = "\(baseURL)pokemon/\(id.description)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let request = NetworkRequest<PokemonDetailModel>(method: .get, url: url)
        return try await networkManager.getNetworkResponse(request)
    }

    func fetchPokemonSpecies(id: Int) async throws -> PokemonSpecies {
        let urlString = "\(baseURL)pokemon-species/\(id.description)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        let request = NetworkRequest<PokemonSpecies>(method: .get, url: url)
        return try await networkManager.getNetworkResponse(request)
    }
}

private extension NetworkRequest where ResponseType == PokemonList {
    static func getPokemons(limit: Int, offset: Int) -> NetworkRequest<PokemonList> {
        let urlString = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        guard let url = URL(string: urlString) else {
            fatalError("Invalid URL: \(urlString)")
        }

        return NetworkRequest<PokemonList>(
            method: .get,
            url: url,
            headers: nil,
            body: nil
        )
    }
}
