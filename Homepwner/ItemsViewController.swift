//
//  ItemsViewControler.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 26/10/23.
//

import UIKit

class ItemsViewController: UITableViewController{
    
    var itemStore: ItemStore!
    var lastItem: Item!
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
        
        let newItem = itemStore.createItem()
        
        if var index = itemStore.allItems.firstIndex(of: newItem) {
            
//            itemStore.moveItem(from: index-1, to: index)
            itemStore.reorderLastItem()
            
            index -= 1
            
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemStore.allItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! ItemCell
        
        
        let item = itemStore.allItems[indexPath.row]
        
        //cell.textLabel?.text = item.name
        //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        cell.setColor(dolarValue: item.valueInDollars)
        
        if item == itemStore.allItems.last{
            cell.isUserInteractionEnabled = false
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit edditingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        
        if edditingStyle == .delete{
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action) -> Void in
                
                self.itemStore.removeItem(item)
                
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            })
            
            ac.addAction(cancelAction)
            ac.addAction(deleteAction)
            
            present(ac, animated: true, completion: nil)
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
        tableView.reloadData()

    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lastItem = itemStore.allItems.last
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        
        
        
    }
    
    
//    FORMA ELEGANTE DE HACER EL NO MORE ITEMS
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        let footerView = UITextView(frame: CGRect(x: 0, y: 0, width: 200, height: 44))
//        footerView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15)
//        footerView.textAlignment = .center
//        footerView.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin]
//        footerView.text = "No more items!"
//        footerView.font = UIFont(name:"Arial", size: 18)
//        self.tableView.tableFooterView = footerView
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        switch segue.identifier{
        case "showItem"?:
            
            if let row = tableView.indexPathForSelectedRow?.row {
               
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
                
            }
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
}
    

