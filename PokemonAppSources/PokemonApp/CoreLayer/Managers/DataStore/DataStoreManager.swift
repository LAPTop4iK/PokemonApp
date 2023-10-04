////
////  DataStoreManager.swift
////  PokemonApp
////
////  Created by Mikita Laptsionak on 3/10/2023.
////
//
//import Foundation
//import CoreData
//
//final class DataStoreManager {
//    
//    private static var persistentContainerError: DataStoreErrors?
//    
//    private static var persistentContainer: NSPersistentContainer = {
//        let container = NSPersistentContainer(name: "MovieVIPERApp")
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                persistentContainerError = .persistentContainerError
//            }
//        })
//        return container
//    }()
//    
//    private lazy var viewContext: NSManagedObjectContext = {
//        return Self.persistentContainer.viewContext
//    }()
//}
//
////MARK: - DataStoreManager Protocol
//
//extension DataStoreManager: DataStoreManagerProtocol {
//    
//    // Сохранение списка фильмов
//    func savePokemonList(_ pokemonList: PokemonList, completion: (Result<Void, DataStoreErrors>) -> Void) {
//        guard DataStoreManager.persistentContainerError == nil else {
//            completion(.failure(.persistentContainerError))
//            return
//        }
//        
//        for pokemon in pokemonList.results {
//            let pokemonEntity = PokemonListEntity(context: viewContext)
//            pokemonEntity.configure(with: pokemon)
//        }
//        
//        do {
//            try viewContext.save()
//            completion(.success(()))
//        } catch {
//            completion(.failure(.saveError))
//        }
//    }
//    
//    // Загрузка списка фильмов с пагинацией
//    func loadPokemonList(offset: Int, limit: Int, completion: (Result<PokemonList, DataStoreErrors>) -> Void) {
//        guard DataStoreManager.persistentContainerError == nil else {
//            completion(.failure(.persistentContainerError))
//            return
//        }
//        
//        let fetchRequest: NSFetchRequest<PokemonListEntity> = PokemonListEntity.fetchRequest()
//        fetchRequest.fetchLimit = limit
//        fetchRequest.fetchOffset = offset
//        
//        do {
//            let entities = try viewContext.fetch(fetchRequest)
//            let pokemons = entities.compactMap { $0.toPokemonListItem() }
//            completion(.success(pokemons))
//        } catch {
//            completion(.failure(.fetchError))
//        }
//    }
//    
//    // Сохранение деталей фильма
//    func savePokemonDetail(_ pokemonDetail: PokemonDetail, completion: (Result<Void, DataStoreErrors>) -> Void) {
//        guard DataStoreManager.persistentContainerError == nil else {
//            completion(.failure(.persistentContainerError))
//            return
//        }
//        
//        let pokemonEntity = PokemonDetailEntity(context: viewContext)
//        pokemonEntity.configure(with: pokemonDetail)
//        
//        do {
//            try viewContext.save()
//            completion(.success(()))
//        } catch {
//            completion(.failure(.saveError))
//        }
//    }
//    
//    // Загрузка деталей фильма по ID
//    func loadPokemonDetail(id: Int64, completion: (Result<PokemonDetail?, DataStoreErrors>) -> Void) {
//        guard DataStoreManager.persistentContainerError == nil else {
//            completion(.failure(.persistentContainerError))
//            return
//        }
//        
//        let fetchRequest: NSFetchRequest<PokemonDetailEntity> = PokemonDetailEntity.fetchRequest()
//        fetchRequest.predicate = NSPredicate(format: "id == %d", id)
//        fetchRequest.fetchLimit = 1
//        
//        do {
//            let entity = try viewContext.fetch(fetchRequest).first
//            let pokemonDetail = entity?.toPokemonDetail()
//            completion(.success(pokemonDetail))
//        } catch {
//            completion(.failure(.fetchError))
//        }
//    }
//}
