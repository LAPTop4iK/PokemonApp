//
//  ImageModel.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import UIKit

struct ImageModel {
    let url: String
    let data: Data?
    
    var image: UIImage? {
        guard let data else { return nil }
        
        return UIImage(data: data)
    }
}
