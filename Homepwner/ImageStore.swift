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

        let url = self.imageURL(forKey: key)
        do{
            if let data = image.jpegData(compressionQuality: 0.5 ){
                try data.write(to: url, options: .atomic)
            }
        } catch{
            print("\(error)")
        }
        
    }
    
    func image(forKey key: String) -> UIImage? {

        if let existingImage = cache.object(forKey: key as NSString){
            return existingImage
        }

        let url = self.imageURL(forKey: key)
        guard let imageFromDisk = UIImage(contentsOfFile: url.path) else { return nil
        }
            
        cache.setObject(imageFromDisk, forKey: key as NSString)
        return imageFromDisk
        
    }
    
    func deleteImage(forKey key: String){
        cache.removeObject(forKey: key as NSString)
        
        let url = self.imageURL(forKey: key)
        
        do{
            
            try FileManager.default.removeItem(at: url)
        }catch let deleteError{
            print("\(deleteError)")
        }
        
    }
    
    func imageURL(forKey key: String)->URL {
        let documentDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentDirectories.first!
        
        
        return documentDirectory.appendingPathComponent(key)
    }
}
