//
//  ColoredBorderTextField.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 7/11/23.
//

import UIKit

class ColoredBorderTextField: UITextField{
    
    override func becomeFirstResponder() -> Bool {
        let a = super.becomeFirstResponder()
        
        self.borderStyle = .line
        
        return a
    }
    
    override func resignFirstResponder() -> Bool {
        self.borderStyle = .roundedRect
        let a = super.resignFirstResponder()
        self.borderStyle = .roundedRect
        
        return a
    }
    
    
}
