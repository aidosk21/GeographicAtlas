//
//  File.swift
//  GeographicAtlas
//
//  Created by Aidos on 16.05.2023.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {
        cache.totalCostLimit = 100
    }
    
    func getImage(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

