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
    
    static let partsStoryboard: UIStoryboard = UIStoryboard(name: "PartsControl", bundle: nil)
    static let viewController2 = partsStoryboard.instantiateViewController(withIdentifier: "PartsControl") as! PartsControllViewController
    
//    private let viewController1 = FontControlViewController()
    private let viewController2 = PartsControllViewController()
    
    fileprivate var componentType: ComponentType {
        return .all(menuOptions: MenuOptions(), pagingControllers: pagingControllers)
    }
    
    fileprivate var pagingControllers: [UIViewController] {
        return [PagingMenuOptions.viewController1, viewController2]
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
            return .roundRect(radius: 5, horizontalPadding: 30, verticalPadding: 5, selectedColor: UIColor.darkGray)
        }
        
        var height: CGFloat {
            return 40
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
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

