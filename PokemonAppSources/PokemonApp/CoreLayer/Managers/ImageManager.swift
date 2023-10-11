//
//  ImageManager.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//
import Foundation

enum ImageError: Error {
    case invalidURL
    case non200StatusCode
}

final class ImageManager {
    private var dataStoreManager: DataStoreManager<ImageEntity, ImageModel>
    
    init(dataStoreManager: DataStoreManager<ImageEntity, ImageModel> = DataStoreManager<ImageEntity, ImageModel>()) {
        self.dataStoreManager = dataStoreManager
    }

    func fetchImage(withURL url: String) async throws -> Data {
        if let localData = try await dataStoreManager.load(identifier: url.description, identifierType: .url),
           let imageData = localData.data {
            return imageData
        } else {
            let data = try await downloadImage(from: url)
            try await dataStoreManager.save(model: ImageModel(url: url, data: data))
            return data
        }
    }
    
    private func downloadImage(from url: String) async throws -> Data {
        guard let url = URL(string: url) else {
            throw ImageError.invalidURL
        }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw ImageError.non200StatusCode
        }
        
        return data
    }
}
