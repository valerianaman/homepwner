//
//  DetailViewController.swift
//  Homepwner
//
//  Created by Gonzalo Benítez Bueno on 6/11/23.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet weak var changeDateButton: UIButton!
    @IBOutlet weak var nameField: ColoredBorderTextField!
    @IBOutlet weak var serialField: ColoredBorderTextField!
    @IBOutlet weak var valueField: ColoredBorderTextField!
    @IBOutlet weak var dateCreatedLabel: ColoredBorderTextField!
    @IBOutlet var imageView: UIImageView!
    
    var item: Item! {
        didSet{
            navigationItem.title = item.name
        }
    }
    
    var imageStore: ImageStore!
    
    
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
        let imageToDisplay = imageStore.image(forKey: item.itemKey)
        imageView.image = imageToDisplay
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
    
    @IBAction func takePicture(_ sender: UIBarButtonItem) {
        let imagePicker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            imagePicker.sourceType = .camera
        }
        else
        {
            imagePicker.sourceType = .photoLibrary
        }
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func removePicture(_ sender: UIBarButtonItem){
        
        // logic to remove the picture
        imageStore.deleteImage(forKey: item.itemKey)
        imageView.image = nil
        
    }

        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imageView.image = image
        
        imageStore.setImage(image, forKey: item.itemKey)
        
        dismiss(animated: true, completion: nil)
        
        
    }
}
