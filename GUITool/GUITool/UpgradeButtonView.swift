////
////  UpgradeButtonView.swift
////  GUITool
////
////  Created by yamagishi kensuke on 11/27/16.
////  Copyright © 2016 kensuke yamagishi. All rights reserved.
////
//
//import UIKit
//
//@objc protocol UpgradeButtonDelegate {
//    // デリゲートメソッド定義
//    func changeStatus(str:String)
//}
//
//class UpgradeButtonView: UIView {
//    
//    //インスタンスを宣言
//    weak var delegate: UpgradeButtonDelegate?
//    
//    override func draw(_ rect: CGRect) {
//        let button = UIButton()
//        button.setTitle("Tap", for: .normal)
//        button.frame = CGRectMake(0, 0, 50, 50)
//        button.backgroundColor = UIColor.red
//        button.addTarget(self, action: Selector(("tappedButton:")), for:.touchUpInside)
//        
//        self.addSubview(button)
//        self.backgroundColor = UIColor.black
//    }
//    
//    @IBAction func tappedButton(sender: AnyObject) {
//        self.backgroundColor = UIColor.green
//        
//        // デリゲートメソッドを呼ぶ(処理をデリゲートインスタンスに委譲する)
//        self.delegate?.changeStatus(str: "グリーン")
//    }
//    
//    
//}
//
//func CGRectMake(_ x: CGFloat, _ y: CGFloat, _ width: CGFloat, _ height: CGFloat) -> CGRect {
//    return CGRect(x: x, y: y, width: width, height: height)
//}
