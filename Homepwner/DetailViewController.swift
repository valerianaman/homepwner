//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 6/11/23.
//

import UIKit

class DetailViewController: UIViewController{
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var serialField: UITextField!
    @IBOutlet weak var valueField: UITextField!
    @IBOutlet weak var dateCreatedLabel: UILabel!

    var item: Item!
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.locale = Locale.current
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        
       let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        return formatter
        
    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        nameField.text = item.name
        valueField.text = numberFormatter.string(from: NSNumber(value: item.valueInDollars))
        serialField.text = item.serialNumber
        dateCreatedLabel.text = dateFormatter.string(from: item.dataCreated)
    }
}
