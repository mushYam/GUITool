//
//  InheritViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 12/9/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

class InheritViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setViewButton() {
        let viewButton = UIView()
        viewButton.frame = CGRect(x: 80, y: 80, width: 120, height: 50)
        viewButton.backgroundColor = UIColor.hex(hexStr: "333333", alpha:1)
        self.view.addSubview(viewButton)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
