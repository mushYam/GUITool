//
//  PartsControllViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/28/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

class PartsControllViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var listTable: UITableView!
    
    var fontKindArray = [String]()
    
//    let statusBarHeight = UIApplication.shared.statusBarFrame.height
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setListData()
        self.setInitialLayout()
    }
    
    func setInitialLayout() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: self.view.frame.height-64
        )
        
        self.view.addSubview(tableView)
    }
    
    func setListData() {
        
        UIFont.familyNames.forEach { (familyName) in
            let fontsInFamily = UIFont.fontNames(forFamilyName: familyName)
            fontsInFamily.forEach({ (fontName) in
                fontKindArray.append(fontName)
            })
        }
        
        
    
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作る
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.textLabel?.text = "このフォントは何でしょう" // タイトル
        cell.textLabel?.font = UIFont(name: fontKindArray[indexPath.row] as String,size: 20)
        cell.detailTextLabel?.text = fontKindArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // セルの数を設定
        return fontKindArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // セルの高さを設定
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // セルがタップされた時の処理
        print("タップされたセルのindex番号: \(indexPath.row)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
