//
//  ItemStore.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 26/10/23.
//

import UIKit

class ItemStore{
    
    var allItems = [Item]()
    
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
    

    
    init(){
        for _ in 0..<5{
            createItem()
        }
        createLastItem()
    }
    
}
