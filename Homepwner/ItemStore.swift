//
//  ItemStore.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 26/10/23.
//

import UIKit

class ItemStore{
    
    var allItems = [Item]()
    
    let itemArchiveURL: URL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("items.archive")
    }()
    
    func saveChanges()->Bool{
        print("Saving items to \(itemArchiveURL.path)")
        
        do{
            let data = try NSKeyedArchiver.archivedData(withRootObject: allItems, requiringSecureCoding: false)
            try data.write(to: itemArchiveURL)
            return true
        } catch {
            return false
        }
    }
        
    
    @discardableResult func createItem() -> Item{
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        
        return newItem
        
    }
    
    @discardableResult func createLastItem() -> Item {
        let newItem = Item(name: "No more Items!", valueInDollars:0)
        
        allItems.append(newItem)
        
        return newItem
        
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    func reorderLastItem(){
        let lastItemIndex = allItems.count-1
        let noMoreItems = allItems[lastItemIndex-1]
        
        allItems.remove(at: lastItemIndex-1)
        allItems.insert(noMoreItems, at: lastItemIndex)
        
        
        
    }
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        
        let lastItemIndex = allItems.count - 1
        
        
        if fromIndex == toIndex{
            return
        }
        
        if toIndex == lastItemIndex{
            return
        }
        
        let movedItem = allItems[fromIndex]
        
        allItems.remove(at: fromIndex)
        
        allItems.insert(movedItem, at: toIndex)
        
        
        
    }
    

    
//    init(){
//        for _ in 0..<5{
//            createItem()
//        }
//        createLastItem()
//    }
           
    init(){
        
        if let nsData = NSData(contentsOf: self.itemArchiveURL){
            do{
                let data  = Data(referencing:nsData)
                
                let myUnarchiver = try NSKeyedUnarchiver(forReadingFrom: data)
                myUnarchiver.requiresSecureCoding = false
                
                self.allItems = myUnarchiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! [Item]
            }catch{
                print("\(error)")
            }
        }
    }
}
