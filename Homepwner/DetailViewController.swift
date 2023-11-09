//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 6/11/23.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var changeDateButton: UIButton!
    @IBOutlet weak var nameField: ColoredBorderTextField!
    @IBOutlet weak var serialField: ColoredBorderTextField!
    @IBOutlet weak var valueField: ColoredBorderTextField!
    @IBOutlet weak var dateCreatedLabel: ColoredBorderTextField!

    var item: Item! {
        didSet{
            navigationItem.title = item.name
        }
    }
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        view.endEditing(true)
        
        item.name = nameField.text ?? ""
        item.serialNumber = serialField.text
        
        if let valueText = valueField.text, let value = numberFormatter.number(from: valueText){
            item.valueInDollars = value.intValue
        }else{
            item.valueInDollars = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier{
        case "changeDate"?:
            let changeDateController = segue.destination as! datePickerController
            changeDateController.item = item
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
}
