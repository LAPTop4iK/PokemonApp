//
//  PokemonEntity+CoreDataProperties.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//
import CoreData

@objc(DetailPokemonInfoEntity)
public class DetailPokemonInfoEntity: NSManagedObject {
    @NSManaged public var name: String
    @NSManaged public var id: Int64
    @NSManaged public var weight: Int64
    @NSManaged public var height: Int64
    @NSManaged public var types: NSOrderedSet
    @NSManaged public var imageUrl: String?
    @NSManaged public var flavorText: String?
}

extension DetailPokemonInfoEntity: ConvertibleEntity {
    typealias ModelType = DetailPokemonInfo

    func configure(with model: ModelType) {
        guard let context = managedObjectContext else { return }

        name = model.name
        id = Int64(model.id)
        weight = Int64(model.weight)
        height = Int64(model.height)
        imageUrl = model.imageUrl
        flavorText = model.flavorText

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

        return DetailPokemonInfo(
            name: name,
            id: Int(id),
            weight: Int(weight),
            height: Int(height),
            types: types,
            imageUrl: imageUrl,
            flavorText: flavorText
        )
    }
}

@objc(TypeOfPowerEntity)
public class TypeOfPowerEntity: NSManagedObject {
    @NSManaged public var name: String
}

extension TypeOfPowerEntity: ConvertibleEntity {
    typealias ModelType = TypeOfPower

    func configure(with model: ModelType) {
        name = model.rawValue
    }

    func toModel() -> ModelType? {
        return TypeOfPower(rawValue: name)
    }
}
