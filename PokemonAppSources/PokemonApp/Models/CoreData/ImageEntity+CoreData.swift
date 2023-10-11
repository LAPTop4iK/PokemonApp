//
//  ImageEntity+CoreData.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import CoreData

@objc(ImageEntity)
public class ImageEntity: NSManagedObject {
    @NSManaged public var url: String?
    @NSManaged public var data: Data?
}

extension ImageEntity: ConvertibleEntity {
    typealias ModelType = ImageModel

    func configure(with model: ImageModel) {
        url = model.url
        data = model.data
    }

    func toModel() -> ImageModel? {
        guard let url else { return nil }
        return ImageModel(url: url, data: data)
    }
}
