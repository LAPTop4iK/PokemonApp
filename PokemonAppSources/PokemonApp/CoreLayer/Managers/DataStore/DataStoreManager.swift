//
//  DataStoreManager.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 3/10/2023.
//

import CoreData
import Foundation

enum IdentifierType {
    case id
    case url
}

class PersistentContainerWrapper {
    static let shared = PersistentContainerWrapper()

    private(set) var initializationError: DataStoreErrors?

    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PokemonApp") // Имя должно соответствовать имени вашей модели данных.
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                debugPrint("Ошибка инициализации PersistentContainer: \(error)")
                shared.initializationError = .persistentContainerError
            }
        })
        return container
    }()

    private init() {}
}

final class DataStoreManager<EntityType: NSManagedObject, ModelType>: DataStoreManagerProtocol where EntityType: ConvertibleEntity, ModelType == EntityType.ModelType {
    typealias Entity = EntityType
    typealias Model = ModelType

    private var viewContext: NSManagedObjectContext

    init(viewContext: NSManagedObjectContext = PersistentContainerWrapper.shared.persistentContainer.viewContext) {
        self.viewContext = viewContext
    }

    func save(model: Model) async throws {
        guard PersistentContainerWrapper.shared.initializationError == nil else {
            throw DataStoreErrors.persistentContainerError
        }

        return try await viewContext.perform {
            let entity = Entity(context: self.viewContext)
            entity.configure(with: model)
            try self.viewContext.save()
        }
    }

    func save(models: [Model]) async throws {
        guard PersistentContainerWrapper.shared.initializationError == nil else {
            throw DataStoreErrors.persistentContainerError
        }

        return try await viewContext.perform {
            for model in models {
                let entity = Entity(context: self.viewContext)
                entity.configure(with: model)
            }
            try self.viewContext.save()
        }
    }

    func load(identifier: String?, identifierType: IdentifierType = .id) async throws -> Model? {
        guard PersistentContainerWrapper.shared.initializationError == nil else {
            throw DataStoreErrors.persistentContainerError
        }

        return try await viewContext.perform {
            let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest() as? NSFetchRequest<Entity> ?? NSFetchRequest<Entity>()
            if let id = identifier {
                let keyPath = (identifierType == .id) ? "id" : "url"
                fetchRequest.predicate = NSPredicate(format: "\(keyPath) == %@", id)
            }
            let entity = try self.viewContext.fetch(fetchRequest).first
            return entity?.toModel()
        }
    }

    func load(offset: Int, limit: Int) async throws -> [Model] {
        guard PersistentContainerWrapper.shared.initializationError == nil else {
            throw DataStoreErrors.persistentContainerError
        }

        return try await viewContext.perform {
            let fetchRequest: NSFetchRequest<Entity> = Entity.fetchRequest() as? NSFetchRequest<Entity> ?? NSFetchRequest<Entity>()
            fetchRequest.fetchOffset = offset
            fetchRequest.fetchLimit = limit

            let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
            fetchRequest.sortDescriptors = [sortDescriptor]

            let entities = try self.viewContext.fetch(fetchRequest)
            return entities.compactMap { $0.toModel() }
        }
    }
}
