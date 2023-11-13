//
//  Item.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 26/10/23.
//

import UIKit

class Item: NSObject, NSCoding{

    
    var name:String
    var valueInDollars: Int
    var serialNumber: String?
    var dateCreated: Date
    var itemKey: String
    
    
    // MARK: NSCoding
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(dateCreated, forKey: "dateCreated")
        coder.encode(itemKey, forKey: "itemKey")
        coder.encode(serialNumber, forKey: "serialNumber")
        coder.encode(valueInDollars, forKey: "valueInDollars")
    }
    
    required init?(coder aCoder: NSCoder) {
        name = aCoder.decodeObject(forKey: "name") as! String
        dateCreated = aCoder.decodeObject(forKey: "dateCreated") as! Date
        itemKey = aCoder.decodeObject(forKey: "itemKey") as! String
        serialNumber = aCoder.decodeObject(forKey: "serialNumber") as! String?
        valueInDollars = aCoder.decodeInteger(forKey: "valueInDollars")
        
        super.init()
        
        
    }
    init(name: String, serialNumber: String? = nil, valueInDollars: Int) {
        self.name = name
        self.valueInDollars = valueInDollars
        self.serialNumber = serialNumber
        self.dateCreated = Date()
        self.itemKey = UUID().uuidString
        
        super.init()
        
    }
    
    
//    MARK: DOS
    
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
