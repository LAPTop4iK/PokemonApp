//
//  ListPokemonProperty+CoreData.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 4/10/2023.
//
import CoreData

@objc(ListPokemonEntity)
public class ListPokemonEntity: NSManagedObject {
    @NSManaged public var id: Int64
    @NSManaged public var name: String
    @NSManaged public var imageUrl: String?
    @NSManaged public var types: NSOrderedSet
}

extension ListPokemonEntity: ConvertibleEntity {
    typealias ModelType = PokemonDetail

    func configure(with model: ModelType) {
        guard let context = managedObjectContext else { return }

        id = Int64(model.id)
        name = model.name
        imageUrl = model.imageUrl

        let mutableTypes = NSMutableOrderedSet()

        model.types.forEach { typeModel in
            let typeEntity = TypeOfPowerEntity(context: context)
            typeEntity.configure(with: typeModel)
            mutableTypes.add(typeEntity)
        }

        types = NSOrderedSet(orderedSet: mutableTypes)
    }

    func toModel() -> ModelType? {
        guard let typeModels = types.array as? [TypeOfPowerEntity] else {
            return nil
        }

        let types = typeModels.compactMap { $0.toModel() }

        return PokemonDetail(
            id: Int(id),
            name: name,
            imageUrl: imageUrl,
            types: types
        )
    }
}
