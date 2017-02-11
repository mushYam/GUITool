//
//  RootViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 11/27/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit
import PagingMenuController


private struct PagingMenuOptions: PagingMenuControllerCustomizable {
    
    static let fontStoryboard: UIStoryboard = UIStoryboard(name: "FontControl", bundle: nil)
    static let viewController1 = fontStoryboard.instantiateViewController(withIdentifier: "FontControl") as! FontControlViewController
    
    static let partsStoryboard: UIStoryboard = UIStoryboard(name: "PartsControll", bundle: nil)
    static let viewController2 = partsStoryboard.instantiateViewController(withIdentifier: "PartsControll") as! PartsControllViewController
    
//    private let viewController1 = FontControlViewController()
//    private let viewController2 = PartsControllViewController()
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [PagingMenuOptions.viewController1, PagingMenuOptions.viewController2]
    }
    
    fileprivate struct MenuOptions: MenuViewCustomizable {
        var displayMode: MenuDisplayMode {
            return .segmentedControl
        }
        var itemsOptions: [MenuItemViewCustomizable] {
            return [MenuItem1(), MenuItem2()]
        }
        
//        var backgroundColor: UIColor {
//            return UIColor.darkGray
//        }
//
//        var selectedBackgroundColor: UIColor {
//            return UIColor.white
//        }
        
        var focusMode: MenuFocusMode {
            return .roundRect(radius: 5, horizontalPadding: 50, verticalPadding: 5, selectedColor: UIColor.darkGray)
        }
        
        var height: CGFloat {
            return 20
        }
        
    }
    
    fileprivate struct MenuItem1: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("firstTabTitle", comment: "")))
        }
    }
    fileprivate struct MenuItem2: MenuItemViewCustomizable {
        var displayMode: MenuItemDisplayMode {
            return .text(title: MenuItemText(text: NSLocalizedString("secondTabTitle", comment: "")))
        }
    }
}

class RootViewController: UIViewController {
        
    override func viewDidLoad() {
        super.viewDidLoad()

//        let userDefaults = UserDefaults.standard
//        if userDefaults.string(forKey: "isLaunch") == "isLaunch"{
//            let storyboard: UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
//            let nextView = storyboard.instantiateViewController(withIdentifier: "Intro") as! IntroViewController
//            self.present(nextView, animated: true, completion: nil)
//        }
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Intro", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "Intro") as! IntroViewController
        self.present(nextView, animated: false, completion: nil)
        
        self.navigationController?.navigationBar.barTintColor = UIColor.hex(hexStr: "4D4D4D", alpha:1)
        
        let options = PagingMenuOptions()
        let pagingMenuController = PagingMenuController(options: options)
        pagingMenuController.view.frame.origin.y += 64
        pagingMenuController.view.frame.size.height -= 64
        pagingMenuController.onMove = { state in
            switch state {
            case let .willMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .didMoveController(menuController, previousMenuController):
                print(previousMenuController)
                print(menuController)
            case let .willMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            case let .didMoveItem(menuItemView, previousMenuItemView):
                print(previousMenuItemView)
                print(menuItemView)
            }
        }
        
        addChildViewController(pagingMenuController)
        view.addSubview(pagingMenuController.view)
        pagingMenuController.didMove(toParentViewController: self)
        
        let viewButton = UIButton()
        viewButton.frame = CGRect(x: self.view.frame.size.width-75, y: self.view.frame.size.height-75, width: 60, height: 60)
        //        viewButton.backgroundColor = UIColor.hex(hexStr: "333333", alpha:1)
        viewButton.addTarget(self, action: #selector(self.tappedButton(sender:)), for:.touchUpInside)
        viewButton.setImage(UIImage(named:"buttonImage"), for: .normal)
        viewButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(viewButton)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        
    }
    
    func tappedButton(sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "PartsUpgrade", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "PartsUpgrade") as! PartsUpgradeViewController
//        nextView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
//        nextView.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        self.present(nextView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
}

