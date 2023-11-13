//
//  datePickerController.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 8/11/23.
//

import UIKit

class datePickerController:UIViewController{
    
    var item: Item!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        datePicker.date = item.dateCreated
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        item.dateCreated = datePicker.date
    }
    
}
