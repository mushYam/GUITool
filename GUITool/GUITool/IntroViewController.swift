//
//  IntroViewController.swift
//  GUITool
//
//  Created by yamagishi kensuke on 12/12/16.
//  Copyright © 2016 kensuke yamagishi. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController,UIScrollViewDelegate {

    let scrollView = UIScrollView()
    let pageControl = UIPageControl()
    var imageArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setLayout()
    }
    
    func setLayout() {
        
        imageArray = ["pageOne","pageTwo","pageThree"]
        
        scrollView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.contentSize = CGSize(
            width: self.view.frame.width*3,
            height: self.view.frame.height
        )
        self.view.addSubview(scrollView)
        
        for i in 0 ..< imageArray.count {
            let img:UIImage = UIImage(named:self.imageArray[i])!;
            let iv:UIImageView = UIImageView(image:img);
            iv.frame = CGRect(x: CGFloat(i) * self.view.frame.size.width, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
            scrollView.addSubview(iv)
        }
        
        pageControl.frame = CGRect(x: 0, y: self.view.frame.size.height-30, width: self.view.frame.size.width, height:30)
        pageControl.tintColor = UIColor.darkGray
        pageControl.numberOfPages = imageArray.count
        pageControl.currentPage = 0
        pageControl.isUserInteractionEnabled = false
        self.view.addSubview(pageControl)
        
        let viewButton = UIButton()
        viewButton.frame = CGRect(x: self.view.frame.size.width-75, y: self.view.frame.size.height-75, width: 60, height: 60)
        viewButton.addTarget(self, action: #selector(self.tappedButton(sender:)), for:.touchUpInside)
        viewButton.setImage(UIImage(named:"buttonImage"), for: .normal)
        viewButton.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        self.view.addSubview(viewButton)
        
        let userDefaults = UserDefaults.standard
        userDefaults.set("done", forKey: "isLaunch")
        userDefaults.synchronize()
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if fmod(scrollView.contentOffset.x, scrollView.frame.maxX) == 0 {
            pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.frame.maxX)
        }
    }
    
    func tappedButton(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
