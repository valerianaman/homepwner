//
//  Item.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 26/10/23.
//

import UIKit

class Item: NSObject{
    var name:String
    var valueInDollars: Int
    var serialNumber: String?
    var dataCreated: Date
    var itemKey: String
    
    
    init(name: String, serialNumber: String? = nil, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dataCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
        
    }
    
    convenience init(random: Bool = false){
        
        if random {
            let adjectives = ["Fluffy", "Rusty", "Shiny"]
            let nouns = ["Bear", "Spork", "Mac"]
            
            let idx = arc4random_uniform(UInt32(adjectives.count))
            let randomAdjective = adjectives[Int(idx)]
            
            let randomNoun = nouns[Int(idx)]
            let randomName = "\(randomAdjective) \(randomNoun)"
            let randomValue = Int(arc4random_uniform(100))
            let randomSerialNumber = UUID().uuidString.components(separatedBy: "-").first!
            
            self.init(name: randomName, serialNumber: randomSerialNumber, valueInDollars: randomValue)
        }
        else{
            self.init(name: "", serialNumber: nil, valueInDollars: 0)
        }
    }
    
}
