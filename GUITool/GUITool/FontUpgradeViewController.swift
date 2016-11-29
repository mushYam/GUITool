//
//  FontUpgradeViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/27/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

protocol FontModalDelegate{
    func fontModalFinished(text: String,textColor :String,fontSize :String,font :String, backGroundColor :String, fontKind :String)
}

class FontUpgradeViewController: UIViewController,UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate {
    
    var delegate: FontModalDelegate! = nil
    
    @IBOutlet weak var text: UILabel!
    @IBOutlet weak var textColor: UILabel!
    @IBOutlet weak var fontSize: UILabel!
    @IBOutlet weak var font: UILabel!
    @IBOutlet weak var backgroundColor: UILabel!
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var textColorField: UITextField!
    @IBOutlet weak var fontSizeField: UITextField!
    @IBOutlet weak var fontField: UITextField!
    @IBOutlet weak var backgroundColorField: UITextField!
    
    
    @IBOutlet weak var fontKindTextField: UITextField!
    
    var textValue: String!
    var textColorValue: String!
    var fontSizeValue: String!
    var fontValue: String!
    var backgroundColorValue: String!
    
    var fontSizeArray = [String]()
    let fontSizePickerView = UIPickerView()
    
    var fontArray = [String]()
    let fontPickerView = UIPickerView()
    var fontMatchNum = -1
    
    var fontKindArray = [String]()
    let fontKindPickerView = UIPickerView()
    var fontKindValue: String!
    
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDelegate()
        self.setData()
        self.setValue()
        self.setLayout()
    }
    
    func setDelegate() {
        self.textField.delegate = self
        self.textColorField.delegate = self
        
        self.fontSizeField.delegate = self
        self.fontSizePickerView.delegate = self
        self.fontSizePickerView.dataSource = self
        
        self.fontField.delegate = self
        self.fontPickerView.delegate = self
        self.fontPickerView.dataSource = self
       
        self.backgroundColorField.delegate = self
        
        self.fontKindTextField.delegate = self
        self.fontKindPickerView.delegate = self
        self.fontKindPickerView.dataSource = self
        
    }
    
    func setData() {
        
        for i in 0..<100 {
            let num = String(i)
            fontSizeArray.append(num)
            if num == fontSizeValue {
                self.fontSizePickerView.selectRow(Int(num)!, inComponent: 0, animated: false)
            }
        }

        UIFont.familyNames.forEach { (familyName) in
            let fontsInFamily = UIFont.fontNames(forFamilyName: familyName)
            fontsInFamily.forEach({ (fontName) in
                fontArray.append(fontName)
                fontMatchNum = fontMatchNum+1
                if fontName == fontValue {
                    self.fontPickerView.selectRow(fontMatchNum, inComponent: 0, animated: false)
                }
            })
        }
        
        self.fontKindArray = [NSLocalizedString("select", comment: ""),NSLocalizedString("input", comment: "")]
        self.fontKindPickerView.selectRow(0, inComponent: 0, animated: false)
        
    }
    
    func setValue() {
        self.textField.text = textValue as String?
        self.textColorField.text = textColorValue as String!
        self.textColorField.keyboardType = UIKeyboardType.asciiCapable
        self.fontSizeField.text = fontSizeValue as String!
        self.fontField.text = fontValue as String!
        self.backgroundColorField.text = backgroundColorValue as String!
        self.backgroundColorField.keyboardType = UIKeyboardType.asciiCapable
        
        self.fontKindTextField.text = fontKindValue as String!
    }
    
    func setLayout() {
        self.text.text = NSLocalizedString("text", comment: "")
        self.textColor.text = NSLocalizedString("textColor", comment: "")
        self.fontSize.text = NSLocalizedString("fontSize", comment: "")
        self.font.text = NSLocalizedString("font", comment: "")
        self.backgroundColor.text = NSLocalizedString("wallColor", comment: "")
        
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        let doneButton   = UIBarButtonItem(title: NSLocalizedString("done", comment: ""), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.donePressed))
        let cancelButton = UIBarButtonItem(title: NSLocalizedString("cancel", comment: ""), style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.cancelPressed))
        let spaceButton  = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolBar.setItems([cancelButton,spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
        textColorField.inputAccessoryView = toolBar
        fontSizeField.inputView = fontSizePickerView
        fontSizeField.inputAccessoryView = toolBar
        fontSizeField.tintColor = UIColor.clear
        self.updateInputView()
        fontField.inputAccessoryView = toolBar
        backgroundColorField.inputAccessoryView = toolBar
        fontKindTextField.inputView = fontKindPickerView
        fontKindTextField.inputAccessoryView = toolBar
        fontKindTextField.tintColor = UIColor.clear
        
        
    }
    
    func updateInputView() {
        if fontKindValue == NSLocalizedString("select", comment: "") {
            fontField.inputView = fontPickerView
            fontField.tintColor = UIColor.clear
        } else {
            fontField.inputView = .none
//            fontField.keyboardType = UIKeyboardType.asciiCapable
            //            fontField.inputView = nil
            //            fontField.tintColor =
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
        textValue = self.textField.text as String!
        textColorValue = self.textColorField.text as String!
        fontSizeValue = self.fontSizeField.text as String!
        
        for (index, _) in fontArray.enumerated() {
            if fontArray[index] == self.fontField.text {
                
                fontValue = self.fontField.text as String!
            } else {
                self.fontField.text = fontValue
            }
        }
        backgroundColorValue = self.backgroundColorField.text as String!
        fontKindValue = self.fontKindTextField.text as String!
        
        self.updateInputView()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == fontSizePickerView {
             return fontSizeArray.count
        } else if pickerView == fontPickerView {
             return fontArray.count
        } else {
            return fontKindArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == fontSizePickerView {
            return fontSizeArray[row]
        } else if pickerView == fontPickerView {
            return fontArray[row]
        } else {
            return fontKindArray[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == fontSizePickerView {
            fontSizeField.text = fontSizeArray[row]
        } else if pickerView == fontPickerView {
            fontField.text = fontArray[row]
        } else {
            fontKindTextField.text = fontKindArray[row]
        }
    }
    
    @IBAction func tapOtherPoint(_ sender: AnyObject) {
        self.view.endEditing(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tapClose(_ sender: AnyObject) {
        dismiss(animated: true, completion:{
            self.delegate.fontModalFinished(text: self.textField.text!,textColor :self.textColorField.text!,fontSize :self.fontSizeField.text!,font :self.fontField.text!, backGroundColor :self.backgroundColorField.text!, fontKind :self.fontKindTextField.text!)
            })
    }

}
