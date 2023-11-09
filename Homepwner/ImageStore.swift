//
//  ImageStore.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 9/11/23.
//

import UIKit

class ImageStore{
    
    let cache = NSCache<NSString, UIImage>()
    
    func setImage(_ image: UIImage, forKey key: String){
        cache.setObject(image, forKey: key as NSString)
    }
    
    func image(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func deleteImage(forKey key: String){
        cache.removeObject(forKey: key as NSString)
    }
}
