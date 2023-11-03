//
//  ItemCell.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 2/11/23.
//

import UIKit

class ItemCell: UITableViewCell{
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var serialNumberLabel: UILabel!
    @IBOutlet var valueLabel: UILabel!
    
    func setColor(dolarValue: Int ){
        
        var cellColor: UIColor
        
        if dolarValue > 50{
            cellColor = UIColor.green
        }else{
             cellColor = UIColor.red
        }
        
        self.valueLabel.textColor = cellColor
    }
    
    
}
