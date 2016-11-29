//
//  PartsUpgradeViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/28/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

protocol PartsModalDelegate{
    func partsModalFinished(genre: String,scheme :String)
}

class PartsUpgradeViewController: UIViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {

    var delegate: PartsModalDelegate! = nil
    
    @IBOutlet weak var genre: UILabel!
    @IBOutlet weak var genreTextField: UITextField!
    
    @IBOutlet weak var scheme: UILabel!
    @IBOutlet weak var schemeTextField: UITextField!
    
    var genreValue: String!
    var schemeValue: String!
    
    var genreArray = [String]()
    let genrePickerView = UIPickerView()
    
    var schemeArray = [String]()
    let schemePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDelegate()
        self.setData()
        self.setValue()
        self.setLayout()
    }
    
    func setDelegate() {
        genreTextField.delegate = self
        schemeTextField.delegate = self
        
        genrePickerView.delegate = self
        genrePickerView.dataSource = self
        genreTextField.inputView = genrePickerView
        
        schemePickerView.delegate = self
        schemePickerView.dataSource = self
        schemeTextField.inputView = schemePickerView
        
    }
    
    func setData() {
        
        self.genreArray = [NSLocalizedString("genreOne", comment: ""),NSLocalizedString("genreTwo", comment: "")]
        
        for (index, _) in genreArray.enumerated() {
            if genreArray[index] == genreValue {
                genrePickerView.selectRow(index, inComponent: 0, animated: false)
            }
        }
        
        self.schemeArray = [NSLocalizedString("schemeOne", comment: ""),NSLocalizedString("schemeTwo", comment: ""),NSLocalizedString("schemeThree", comment: ""),NSLocalizedString("schemeFour", comment: "")]
        
        for (index, _) in schemeArray.enumerated() {
            if schemeArray[index] == schemeValue {
                schemePickerView.selectRow(index, inComponent: 0, animated: false)
            }
        }
    }
    
    func setValue() {
        genreTextField.text = genreValue
        schemeTextField.text = schemeValue
    }
    
    func setLayout() {
        
        self.hiddenScheme()
        
        genre.text = NSLocalizedString("genre", comment: "")
        scheme.text = NSLocalizedString("scheme", comment: "")
        
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        let doneButton   = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.donePressed))
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("cancel", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelPressed))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        
        genreTextField.inputAccessoryView = toolBar
        genreTextField.tintColor = UIColor.clear
        schemeTextField.inputAccessoryView = toolBar
        schemeTextField.tintColor = UIColor.clear
    }
    
    func hiddenScheme() {
        if genreValue == NSLocalizedString("genreTwo", comment: "") {
            scheme.isHidden = true
            schemeTextField.isHidden = true
        } else {
            scheme.isHidden = false
            schemeTextField.isHidden = false
        }
    }
    
    func donePressed() {
        view.endEditing(true)
        self.setNewValue()
    }
    
    func cancelPressed() {
        self.setValue()
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.setNewValue()
        return true
    }
    
    func setNewValue() {
        genreValue = genreTextField.text as String!
        schemeValue = schemeTextField.text as String!
        self.hiddenScheme()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == genrePickerView {
            return genreArray.count
        } else {
            return schemeArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == genrePickerView {
            return genreArray[row]
        } else {
            return schemeArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == genrePickerView {
            genreTextField.text = genreArray[row]
        } else {
            schemeTextField.text = schemeArray[row]
        }
    }
    
    @IBAction func tapClose(_ sender: AnyObject) {
        dismiss(animated: true, completion: {
            self.delegate.partsModalFinished(genre: self.genreTextField.text!,scheme :self.schemeTextField.text!)
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
