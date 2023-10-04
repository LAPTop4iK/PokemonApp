////
////  DataStoreProtocol.swift
////  PokemonApp
////
////  Created by Mikita Laptsionak on 04/10/2023.
////
//
//import Foundation
//
//enum DataStoreErrors: Error {
//    case deleteError
//    case fetchError
//    case saveError
//    case persistentContainerError
//}
//
//protocol DataStoreManagerProtocol {
//    // Для работы со списком фильмов
//    func savePokemonList(_ pokemonList: PokemonList, completion: (Result<Void, DataStoreErrors>) -> Void)
//    func loadPokemonList(offset: Int, limit: Int, completion: (Result<PokemonList, DataStoreErrors>) -> Void)
//    
//    // Для работы с деталями фильма
//    func savePokemonDetail(_ pokemonDetail: PokemonDetail, completion: (Result<Void, DataStoreErrors>) -> Void)
//    func loadPokemonDetail(id: Int64, completion: (Result<PokemonDetail?, DataStoreErrors>) -> Void)
//}
//
//enum EntityType {
//    case movieList
//    case movieDetail
//}
