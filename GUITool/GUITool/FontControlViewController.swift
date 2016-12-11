//
//  FontControlViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/27/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//


import UIKit

class FontControlViewController: InheritViewController,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource {
    
    var text = UILabel()
    var textColor = UILabel()
    var fontSize = UILabel()
    var font = UILabel()
    var backgroundColor = UILabel()
    
    var textField = UITextField()
    var textColorField = UITextField()
    var fontSizeField = UITextField()
    var fontField = UITextField()
    var backgroundColorField = UITextField()
    
    var fontKindTextField = UITextField()
    
    var fontSizeArray = [String]()
    let fontSizePickerView = UIPickerView()
    
    var fontArray = [String]()
    let fontPickerView = UIPickerView()
    var fontMatchNum = -1
    
    var fontKindArray = [String]()
    let fontKindPickerView = UIPickerView()
    
    let toolBar = UIToolbar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setDelegate()
        self.setData()
        self.setLayout()
        self.setValue()
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
        }
        
        UIFont.familyNames.forEach { (familyName) in
            let fontsInFamily = UIFont.fontNames(forFamilyName: familyName)
            fontsInFamily.forEach({ (fontName) in
                fontArray.append(fontName)
                fontMatchNum = fontMatchNum+1
            })
        }
        
        self.fontKindArray = [NSLocalizedString("select", comment: ""),NSLocalizedString("input", comment: "")]
        self.fontPickerView.selectRow(58, inComponent: 0, animated: false)
        self.fontSizePickerView.selectRow(15, inComponent: 0, animated: false)
        
    }
    
    func setLayout() {
        
        let borderView = UIView()
        borderView.frame = CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 1)
        borderView.backgroundColor = UIColor.hex(hexStr: "333333", alpha:1)
        self.view.addSubview(borderView)
        
        self.text.text = NSLocalizedString("text", comment: "")
        self.textColor.text = NSLocalizedString("textColor", comment: "")
        self.fontSize.text = NSLocalizedString("fontSize", comment: "")
        self.font.text = NSLocalizedString("font", comment: "")
        self.backgroundColor.text = NSLocalizedString("wallColor", comment: "")
        
        self.textField.text = NSLocalizedString("defaultText", comment: "")
        self.textColorField.text = NSLocalizedString("defaultTextColor", comment: "")
        self.fontSizeField.text = NSLocalizedString("defaultFontSize", comment: "")
        self.fontField.text = NSLocalizedString("defaultFont", comment: "")
        self.backgroundColorField.text = NSLocalizedString("defaultBackgroundColor", comment: "")
        self.fontKindTextField.text = NSLocalizedString("select", comment: "")
        
        text.frame = CGRect(x: 30, y: 50, width: 200, height: 20)
        text.font = UIFont(name: "HelveticaNeue",size: 14)
        text.textColor = UIColor.hex(hexStr: "999999", alpha:1)
        self.view.addSubview(text)
        textField.frame = CGRect(x: 30, y: 75, width: self.view.frame.size.width-60, height: 45)
        textField.placeholder = NSLocalizedString("inputText", comment: "")
        textField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        textField.leftViewMode = .always
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        self.view.addSubview(textField)
        
        textColor.frame = CGRect(x: 30, y: 130, width: 200, height: 20)
        textColor.font = UIFont(name: "HelveticaNeue",size: 14)
        textColor.textColor = UIColor.hex(hexStr: "999999", alpha:1)
        self.view.addSubview(textColor)
        textColorField.frame = CGRect(x: 30, y: 155, width: self.view.frame.size.width-60, height: 45)
        textColorField.placeholder = NSLocalizedString("inputColorCode", comment: "")
        textColorField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        textColorField.leftViewMode = .always
        textColorField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        textColorField.clearButtonMode = .whileEditing
        textColorField.returnKeyType = .done
        self.view.addSubview(textColorField)
        
        fontSize.frame = CGRect(x: 30, y: 210, width: 200, height: 20)
        fontSize.font = UIFont(name: "HelveticaNeue",size: 14)
        fontSize.textColor = UIColor.hex(hexStr: "999999", alpha:1)
        self.view.addSubview(fontSize)
        fontSizeField.frame = CGRect(x: 30, y: 235, width: self.view.frame.size.width-60, height: 45)
        fontSizeField.placeholder = NSLocalizedString("inputText", comment: "")
        fontSizeField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        fontSizeField.leftViewMode = .always
        fontSizeField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        fontSizeField.returnKeyType = .done
        self.view.addSubview(fontSizeField)
        
        font.frame = CGRect(x: 30, y: 290, width: 200, height: 20)
        font.font = UIFont(name: "HelveticaNeue",size: 14)
        font.textColor = UIColor.hex(hexStr: "999999", alpha:1)
        self.view.addSubview(font)
        fontField.frame = CGRect(x: 120, y: 315, width: self.view.frame.size.width-150, height: 45)
        fontField.placeholder = NSLocalizedString("inputText", comment: "")
        fontField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        fontField.leftViewMode = .always
        fontField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        fontField.returnKeyType = .done
        self.view.addSubview(fontField)
        fontKindTextField.frame = CGRect(x: 30, y: 315, width: 80, height: 45)
        fontKindTextField.placeholder = NSLocalizedString("inputText", comment: "")
        fontKindTextField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        fontKindTextField.leftViewMode = .always
        fontKindTextField.textAlignment = NSTextAlignment.center
        fontKindTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        fontKindTextField.returnKeyType = .done
        self.view.addSubview(fontKindTextField)
        
        backgroundColor.frame = CGRect(x: 30, y: 370, width: 200, height: 20)
        backgroundColor.font = UIFont(name: "HelveticaNeue",size: 14)
        backgroundColor.textColor = UIColor.hex(hexStr: "999999", alpha:1)
        self.view.addSubview(backgroundColor)
        backgroundColorField.frame = CGRect(x: 30, y: 395, width: self.view.frame.size.width-60, height: 45)
        backgroundColorField.placeholder = NSLocalizedString("inputColorCode", comment: "")
        backgroundColorField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        backgroundColorField.leftViewMode = .always
        backgroundColorField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        backgroundColorField.clearButtonMode = .whileEditing
        backgroundColorField.returnKeyType = .done
        self.view.addSubview(backgroundColorField)
        
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
        fontField.inputAccessoryView = toolBar
        backgroundColorField.inputAccessoryView = toolBar
        fontKindTextField.inputView = fontKindPickerView
        fontKindTextField.inputAccessoryView = toolBar
        fontKindTextField.tintColor = UIColor.clear
        
        self.updateInputView()
        
    }
    
    func setValue() {
        
        var num = 0
        
        for (index, _) in fontArray.enumerated() {
            if fontArray[index] == self.fontField.text {
                num = 1
            } else {
            }
        }
        
        if num != 1 {
            self.fontField.text = ""
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(textField.text, forKey: "text")
        userDefaults.set(textColorField.text, forKey: "textColor")
        userDefaults.set(fontSizeField.text, forKey: "fontSize")
        userDefaults.set(fontField.text, forKey: "font")
        userDefaults.set(backgroundColorField.text, forKey: "wallColor")
        userDefaults.synchronize()
        
    }
    
    func updateInputView() {
        if fontKindTextField.text == NSLocalizedString("select", comment: "") {
            fontField.inputView = fontPickerView
            fontField.tintColor = UIColor.clear
            fontField.clearButtonMode = .never
        } else {
            fontField.inputView = .none
            fontField.tintColor = nil
            fontField.clearButtonMode = .whileEditing
        }
    }
    
    func donePressed() {
        self.scrollToY(value: 0)
        view.endEditing(true)
        self.setValue()
        self.updateInputView()
    }
    
    func cancelPressed() {
        self.scrollToY(value: 0)
        self.setValue()
        view.endEditing(true)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == fontKindTextField || textField == fontField {
            self.scrollToY(value: -200)
        } else if textField == backgroundColorField {
            self.scrollToY(value: -200)
        } else {
            self.scrollToY(value: 0)
        }
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.scrollToY(value: 0)
        textField.resignFirstResponder()
        self.setValue()
        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
//        if (textField == textColorField || textField == backgroundColorField) {
//            let maxLength: Int = 6
//            var str = textField.text! + string
//            if str.characters.count < maxLength {
//                return true
//            }
//            return false
//        }
        
        return true
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
    
    func scrollToY(value: Float) {
        
        UIView.beginAnimations("registerScroll", context: nil)
        UIView.setAnimationCurve(UIViewAnimationCurve.easeInOut)
        UIView.setAnimationDuration(0.4)
        self.view.transform = CGAffineTransform(translationX: 0, y: CGFloat(value));
        UIView.commitAnimations()
        
//                [UIView beginAnimations:@"registerScroll" context:NULL];
//                [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//                [UIView setAnimationDuration:0.4];
//                self.transform = CGAffineTransformMakeTranslation(0, y);
//                [UIView commitAnimations];
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
