//
//  ItemsViewControler.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 26/10/23.
//

import UIKit

class ItemsViewController: UITableViewController{
    
    var itemStore: ItemStore!
    var sections = ["Econom" , "Business"]
    var economItems = [Item]()
    var businessItems = [Item]()
    let bound = 50

    
    func divideItems(){
        for item in itemStore.allItems
        {
            if item.valueInDollars < 50 {
                economItems.append(item)
            }
            else {
                businessItems.append(item)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return itemStore.allItems.count
        if section == 0 {
            return economItems.count
        }else{
            return businessItems.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableviewCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        let itemList: [Item]
        
        
        if indexPath.section == 0{
            itemList = economItems
        }
        else
        {
            itemList = businessItems
        }
        
        //        let item = itemStore.allItems[indexPath.row]
        let item = itemList[indexPath.row]
        
        let backColor = UIColor(red: 103, green: 133, blue: 193, alpha: 0.5)
        
        cell.textLabel?.text = item.name
        cell.backgroundColor = backColor
        cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        cell.textLabel?.backgroundColor = backColor
        cell.detailTextLabel?.backgroundColor = backColor
        cell.textLabel?.font  = UIFont(name:"Arial", size: 20);

        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let footerView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
        footerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
        footerView.textAlignment = .center
        footerView.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin]
        footerView.text = "No more items!"
        footerView.font = UIFont(name:"Arial", size: 18)
        self.tableView.tableFooterView = footerView
    
        self.tableView.backgroundView?.isOpaque = false
        self.tableView.backgroundColor = UIColor(red: 103, green: 133, blue: 193, alpha: 1.0)
        
        
        
        
        self.divideItems()

    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.sections[section]
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
}
