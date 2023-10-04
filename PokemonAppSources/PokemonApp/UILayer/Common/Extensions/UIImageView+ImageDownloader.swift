//
//  UIImageView+ImageDownloader.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 04/10/2023.
//

import UIKit

extension UIImageView {
    
    public func loadImageAsynchronouslyFrom(url: URL,
                                            completion: ((_ image: UIImage?) -> ())? = nil) {
        let request = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: request,
                                   completionHandler: { [weak self] data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        let imageToSave = image
                        self?.image = imageToSave
                        
                        completion?(imageToSave)
                    } else {
                        completion?(nil)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion?(nil)
                }
            }
        }).resume()
    }
}
