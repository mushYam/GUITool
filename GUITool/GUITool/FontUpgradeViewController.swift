//
//  FontUpgradeViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/27/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

protocol FontModalDelegate{
    func fontModalFinished(text: String,textColor :String,fontSize :String,font :String, backGroundColor :String)
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
        self.fontSizeField.inputView = self.fontSizePickerView
        
        self.fontField.delegate = self
        self.fontPickerView.delegate = self
        self.fontPickerView.dataSource = self
        
        self.fontField.inputView = self.fontPickerView
        
        self.backgroundColorField.delegate = self
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
    }
    
    func setValue() {
        self.textField.text = textValue as String?
        self.textColorField.text = textColorValue as String!
        self.textColorField.keyboardType = UIKeyboardType.asciiCapable
        self.fontSizeField.text = fontSizeValue as String!
        self.fontField.text = fontValue as String!
        self.backgroundColorField.text = backgroundColorValue as String!
        self.backgroundColorField.keyboardType = UIKeyboardType.asciiCapable
    }
    
    func setLayout() {
        self.text.text = NSLocalizedString("text", comment: "")
        self.textColor.text = NSLocalizedString("textColor", comment: "")
        self.fontSize.text = NSLocalizedString("fontSize", comment: "")
        self.font.text = NSLocalizedString("font", comment: "")
        self.backgroundColor.text = NSLocalizedString("wallColor", comment: "")
        
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
        
        textField.inputAccessoryView = toolBar
        textColorField.inputAccessoryView = toolBar
        fontSizeField.inputAccessoryView = toolBar
        fontField.inputAccessoryView = toolBar
        backgroundColorField.inputAccessoryView = toolBar
    }
    
    func donePressed() {
        view.endEditing(true)
    }
    
    func cancelPressed() {
        self.setValue()
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        textValue = self.textField.text as String!
        textColorValue = self.textColorField.text as String!
        fontSizeValue = self.fontSizeField.text as String!
        fontValue = self.fontField.text as String!
        backgroundColorValue = self.backgroundColorField.text as String!
        
        return true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == fontSizePickerView {
             return fontSizeArray.count
        } else {
             return fontArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == fontSizePickerView {
            return fontSizeArray[row]
        } else {
            return fontArray[row]
        }

    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == fontSizePickerView {
            fontSizeField.text = fontSizeArray[row]
        } else {
            fontField.text = fontArray[row]
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
            self.delegate.fontModalFinished(text: self.textField.text!,textColor :self.textColorField.text!,fontSize :self.fontSizeField.text!,font :self.fontField.text!, backGroundColor :self.backgroundColorField.text!)
            })
    }

}
