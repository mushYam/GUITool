//
//  PartsUpgradeViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/28/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

//protocol PartsModalDelegate{
//    func partsModalFinished(genre: String,scheme :String)
//}

class PartsUpgradeViewController: UIViewController {
    
    let closeButton = UIButton()
    var flg: Bool = false
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setlayout()
        
    }
    
    func setlayout() {
        let userDefaults = UserDefaults.standard
        let text = UILabel()
        text.frame = CGRect(x: 20, y: 80, width: self.view.frame.size.width-40, height: self.view.frame.size.height-160)
        text.text = userDefaults.string(forKey: "text")!
        text.font = UIFont(name: userDefaults.string(forKey: "font")!,size: CGFloat(NSString(string: userDefaults.string(forKey: "fontSize")!).floatValue))
        text.textAlignment = NSTextAlignment.center
        text.numberOfLines = 0
        text.textColor = UIColor.hex(hexStr:userDefaults.string(forKey: "textColor")!, alpha:1)
        self.view.addSubview(text)
        
        self.view.backgroundColor = UIColor.hex(hexStr:userDefaults.string(forKey: "wallColor")!, alpha:1)
        
        let wall = UIButton()
        wall.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
//        wall.backgroundColor = UIColor.hex(hexStr: "333333", alpha:1)
        wall.addTarget(self, action: #selector(self.hideButton(sender:)), for:.touchUpInside)
//        wall.backgroundColor = UIColor.hex(hexStr:userDefaults.string(forKey: "wallColor")!, alpha:1)
        self.view.addSubview(wall)
        
        closeButton.frame = CGRect(x: self.view.frame.size.width-75, y: self.view.frame.size.height-75, width: 60, height: 60)
        closeButton.backgroundColor = UIColor.hex(hexStr: "333333", alpha:1)
        closeButton.addTarget(self, action: #selector(self.tappedButton(sender:)), for:.touchUpInside)
        closeButton.setImage(UIImage(named:"buttonImage"), for: .normal)
        closeButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(closeButton)
        
    }
    
    func hideButton(sender: AnyObject) {
        
        if flg {
            UIView.animate(withDuration: 0.4, animations: {
                self.closeButton.alpha = 1.0
                }, completion:nil)
            flg = false
        } else {
            UIView.animate(withDuration: 0.4, animations: {
                self.closeButton.alpha = 0.0
                }, completion:nil)
            flg = true
        }
        
    }
    
    func tappedButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    


}
