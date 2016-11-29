//
//  FontControlViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/27/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//


import UIKit

class FontControlViewController: UIViewController,FontModalDelegate {
    
    @IBOutlet weak var firstText: UILabel!
    
    var orgTextValue: String!
    var orgTextColorValue: String!
    var orgFontSizeValue: String!
    var orgFontValue: String!
    var orgBackgroundColorValue: String!
    var orgFontKindValue: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setInitialValue()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setInitialValue() {
        self.orgTextValue = NSLocalizedString("defaultText", comment: "")
        self.orgTextColorValue = NSLocalizedString("defaultTextColor", comment: "")
        self.orgFontSizeValue = NSLocalizedString("defaultFontSize", comment: "")
        self.orgFontValue = NSLocalizedString("defaultFont", comment: "")
        self.orgBackgroundColorValue = NSLocalizedString("defaultBackgroundColor", comment: "")
        self.orgFontKindValue = NSLocalizedString("select", comment: "")
        
        self.changeStatus()
    }
    
    @IBAction func tapFontUpgrade(_ sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "FontUpgrade", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "FontUpgrade") as! FontUpgradeViewController
        nextView.textValue = orgTextValue
        nextView.textColorValue = orgTextColorValue
        nextView.fontSizeValue = orgFontSizeValue
        nextView.fontValue = orgFontValue
        nextView.backgroundColorValue = orgBackgroundColorValue
        nextView.fontKindValue = orgFontKindValue
        
        nextView.delegate = self
        nextView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        nextView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(nextView, animated: true, completion: nil)
    }
    
    func fontModalFinished(text: String,textColor :String,fontSize :String,font :String, backGroundColor :String, fontKind :String){
        
        self.orgTextValue = text as String!
        self.orgTextColorValue = textColor as String!
        self.orgFontSizeValue = fontSize as String!
        self.orgFontValue = font as String!
        self.orgBackgroundColorValue = backGroundColor as String!
        self.orgFontKindValue = fontKind as String!
        
        self.changeStatus()
    }
    
    func changeStatus() {
        self.firstText.text = orgTextValue as String?
        self.firstText.textColor = UIColor.hex(hexStr:orgTextColorValue as String, alpha:1)
        self.firstText.font = UIFont(name: orgFontValue as String,size: CGFloat((orgFontSizeValue as NSString).floatValue))
        self.view.backgroundColor = UIColor.hex(hexStr:orgBackgroundColorValue as String, alpha:1)
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
