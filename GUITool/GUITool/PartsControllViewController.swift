//
//  PartsControllViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/28/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

class PartsControllViewController: InheritViewController,UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var fontKindArray = [String]()
    
    let tableView = UITableView()

    var webColorArray = [] as NSArray
    var flatColorArray = [] as NSArray
    var materialColorArray = [] as NSArray
    
    var copyLabel: String! = ""
    
    var fontArray = [String]()
    var colorArray = [String]()
    
    var kindArray = [String]()
    let kindPickerView = UIPickerView()
    var contentsArray = [String]()
    let contentsPickerView = UIPickerView()
    
    var orgGenreValue: String!
    var orgSchemeValue: String!
    
    let kindTextField = UITextField()
    let contentsTextField = UITextField()
    
    var flg: ObjCBool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setListData()
        self.setInitialLayout()
    }
    
    func setListData() {
        
        UIFont.familyNames.forEach { (familyName) in
            let fontsInFamily = UIFont.fontNames(forFamilyName: familyName)
            fontsInFamily.forEach({ (fontName) in
                fontKindArray.append(fontName)
            })
        }
        
        let bundle = Bundle.main
        webColorArray = NSArray(contentsOf: bundle.url(forResource: "WebSafeColor", withExtension: "plist")!)!
        
        flatColorArray = NSArray(contentsOf: bundle.url(forResource: "FlatColor", withExtension: "plist")!)!
        
        materialColorArray = NSArray(contentsOf: bundle.url(forResource: "FlatColor", withExtension: "plist")!)!
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.rowButtonAction(sender:)))
        longPressRecognizer.allowableMovement = 15
        longPressRecognizer.minimumPressDuration = 0.6
        tableView.addGestureRecognizer(longPressRecognizer)
    }
    
    func rowButtonAction(sender : UILongPressGestureRecognizer) {
        
        let point: CGPoint = sender.location(in: tableView)
        let indexPath = tableView.indexPathForRow(at: point)
        
        if let indexPath = indexPath {
            if sender.state == UIGestureRecognizerState.began {
                
                let board = UIPasteboard.general
                let cell = tableView.cellForRow(at: indexPath)
                if orgGenreValue == NSLocalizedString("genreTwo", comment: "") {
                    board.setValue((cell?.detailTextLabel?.text)!, forPasteboardType: "public.text")
                    copyLabel = (cell?.detailTextLabel?.text)!
                } else {
                    board.setValue((cell?.textLabel?.text)!, forPasteboardType: "public.text")
                    copyLabel = (cell?.textLabel?.text)!
                }
                
                self.showCopy()
            }
        }else{
        }
    }
    
    func showCopy() {
        let alert = UIAlertController(title: NSLocalizedString("copy", comment: ""), message: copyLabel as String!, preferredStyle: .alert)
        self.present(alert, animated: true, completion: {
            UIView.animate(withDuration: 0.8, animations: {
                alert.view.alpha = 0.0
                }, completion: {finished in
                    alert.dismiss(animated: false, completion: nil)
            })
        })
        
    }
    
    func setInitialLayout() {
        
        let borderView = UIView()
        borderView.frame = CGRect(x: 0, y: 10, width: self.view.frame.size.width, height: 1)
        borderView.backgroundColor = UIColor.hex(hexStr: "333333", alpha:1)
        self.view.addSubview(borderView)
        
        orgGenreValue = NSLocalizedString("genreOne", comment: "")
        orgSchemeValue = NSLocalizedString("schemeOne", comment: "")
        
        kindArray = [NSLocalizedString("kindColor", comment: ""),NSLocalizedString("kindFont", comment: "")]
        kindPickerView.selectRow(0, inComponent: 0, animated: false)
        kindPickerView.delegate = self
        kindPickerView.dataSource = self
        
        colorArray = [NSLocalizedString("schemeOne", comment: ""),NSLocalizedString("schemeTwo", comment: ""),NSLocalizedString("schemeThree", comment: "")]
        fontArray = [NSLocalizedString("fontSchemeOne", comment: "")]
        contentsArray = colorArray
        
        contentsPickerView.selectRow(0, inComponent: 0, animated: false)
        contentsPickerView.delegate = self
        contentsPickerView.dataSource = self
        
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
        
        kindTextField.delegate = self
        kindTextField.inputAccessoryView = toolBar
        kindTextField.inputView = kindPickerView
        contentsTextField.delegate = self
        contentsTextField.tintColor = UIColor.clear
        contentsTextField.inputAccessoryView = toolBar
        contentsTextField.inputView = contentsPickerView
        
        kindTextField.frame = CGRect(x: 20, y: 20, width: 80, height: 45)
        kindTextField.text = NSLocalizedString("genreOne", comment: "")
        kindTextField.placeholder = "######"
        kindTextField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        kindTextField.leftViewMode = .always
        kindTextField.tintColor = UIColor.clear
        kindTextField.textAlignment = NSTextAlignment.center
        kindTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.view.addSubview(kindTextField)
        
        contentsTextField.frame = CGRect(x: 110, y: 20, width: self.view.frame.size.width-130, height: 45)
        contentsTextField.text = NSLocalizedString("schemeOne", comment: "")
        contentsTextField.placeholder = "######"
        contentsTextField.backgroundColor = UIColor.hex(hexStr: "999999", alpha:1)
        contentsTextField.leftViewMode = .always
        contentsTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        self.view.addSubview(contentsTextField)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(
            x: 0,
            y: 80,
            width: self.view.frame.width,
            height: self.view.frame.height-164
        )
        self.view.addSubview(tableView)
        
    }

    func donePressed() {
        view.endEditing(true)
        self.updateView()
    }
    
    func cancelPressed() {
        view.endEditing(true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作る
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.selectionStyle = .none
        cell.layoutMargins = .zero
        
        if orgGenreValue == NSLocalizedString("genreTwo", comment: "") {
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = UIColor.lightGray
            cell.textLabel?.text = NSLocalizedString("fontLabel", comment: "")
            cell.textLabel?.font = UIFont(name: fontKindArray[indexPath.row] as String,size: 20)
            cell.detailTextLabel?.text = fontKindArray[indexPath.row]
        } else {
            tableView.separatorStyle = .none
            if orgSchemeValue == NSLocalizedString("schemeOne", comment: "") {
                cell.textLabel?.text = webColorArray[indexPath.row] as? String
                cell.contentView.backgroundColor = UIColor.hex(hexStr:webColorArray[indexPath.row] as! String, alpha:1)
            } else if orgSchemeValue == NSLocalizedString("schemeTwo", comment: "") {
                cell.textLabel?.text = flatColorArray[indexPath.row] as? String
                cell.contentView.backgroundColor = UIColor.hex(hexStr:flatColorArray[indexPath.row] as! String, alpha:1)
            } else if orgSchemeValue == NSLocalizedString("schemeThree", comment: "") {
                cell.textLabel?.text = flatColorArray[indexPath.row] as? String
                cell.contentView.backgroundColor = UIColor.hex(hexStr:flatColorArray[indexPath.row] as! String, alpha:1)
            } else {
                cell.textLabel?.text = flatColorArray[indexPath.row] as? String
                cell.contentView.backgroundColor = UIColor.hex(hexStr:flatColorArray[indexPath.row] as! String, alpha:1)
            }
            
            cell.textLabel?.shadowColor = UIColor.white
            cell.textLabel?.shadowOffset = CGSize(width: 1, height: 1)
            
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if orgGenreValue == NSLocalizedString("genreTwo", comment: "") {
            return fontKindArray.count
        } else {
            if orgSchemeValue == NSLocalizedString("schemeOne", comment: "") {
                return webColorArray.count
            } else if orgSchemeValue == NSLocalizedString("schemeTwo", comment: "") {
                return flatColorArray.count
            } else {
                return materialColorArray.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 94
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
        
    func updateView() {
        
        orgGenreValue = kindTextField.text
        orgSchemeValue = contentsTextField.text
        
        if orgGenreValue == NSLocalizedString("genreOne", comment: "") {
            contentsArray = colorArray
        } else {
            contentsArray = fontArray
        }
        
        if flg.boolValue {
            tableView.reloadData()
            flg = false
        } else {
            flg = false
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == kindPickerView {
            return kindArray.count
        } else {
            return contentsArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        if pickerView == kindPickerView {
            flg = false;
            return kindArray[row]
        } else {
            flg = true;
            return contentsArray[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == kindPickerView {
            kindTextField.text = kindArray[row]
        } else {
            contentsTextField.text = contentsArray[row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension UIColor {
    class func hex ( hexStr : String, alpha : CGFloat) -> UIColor {
        var hexStr = hexStr
        //        var alpha = alpha
        hexStr = hexStr.replacingOccurrences(of: "#", with: "") as String
        let scanner = Scanner(string: hexStr as String)
        var color: UInt32 = 0
        if scanner.scanHexInt32(&color) {
            let r = CGFloat((color & 0xFF0000) >> 16) / 255.0
            let g = CGFloat((color & 0x00FF00) >> 8) / 255.0
            let b = CGFloat(color & 0x0000FF) / 255.0
            return UIColor(red:r,green:g,blue:b,alpha:alpha)
        } else {
            return UIColor.darkGray
        }
    }
}
