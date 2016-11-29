//
//  PartsControllViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/28/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

class PartsControllViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,PartsModalDelegate {
    
    var fontKindArray = [String]()
    
    var orgGenreValue: String!
    var orgSchemeValue: String!
    
    let tableView = UITableView()
    let listModalButton = UIButton()
    
    var webColorArray = [] as NSArray
    var flatColorArray = [] as NSArray
    var materialColorArray = [] as NSArray
    var jaTraditionalColorArray = [] as NSArray
    
    var copyLabel: String! = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitialValue()
        self.setListData()
        self.setInitialLayout()
    }
    
    func setInitialValue() {
        self.orgGenreValue = NSLocalizedString("genreOne", comment: "")
        self.orgSchemeValue = NSLocalizedString("schemeOne", comment: "")
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
        
        jaTraditionalColorArray = NSArray(contentsOf: bundle.url(forResource: "FlatColor", withExtension: "plist")!)!
        
        
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
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = CGRect(
            x: 0,
            y: 0,
            width: self.view.frame.width,
            height: self.view.frame.height-108
        )
        self.view.addSubview(tableView)
        
        listModalButton.frame = CGRect(
            x: self.view.frame.size.width-100,
            y: self.view.frame.size.height-208,
            width: 70,
            height: 70
        )
        listModalButton.backgroundColor = UIColor.yellow
        listModalButton.addTarget(self, action: #selector(self.tappedButton(sender:)), for:.touchUpInside)
        self.view.addSubview(listModalButton)
    }
    
    func tappedButton(sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "PartsUpgrade", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "PartsUpgrade") as! PartsUpgradeViewController
        nextView.genreValue = orgGenreValue
        nextView.schemeValue = orgSchemeValue
        
        nextView.delegate = self
        nextView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        nextView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(nextView, animated: true, completion: nil)
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // セルを作る
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        cell.selectionStyle = .none
        cell.layoutMargins = .zero
        
        if orgGenreValue == NSLocalizedString("genreTwo", comment: "") {
            tableView.separatorStyle = .singleLine
            tableView.separatorColor = UIColor.lightGray
            cell.textLabel?.text = "このフォントは何でしょう"
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
            } else if orgSchemeValue == NSLocalizedString("schemeThree", comment: "") {
                return materialColorArray.count
            } else {
                return jaTraditionalColorArray.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 94
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func partsModalFinished(genre: String,scheme :String) {
        
        orgGenreValue = genre
        orgSchemeValue = scheme
        
        tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
}
