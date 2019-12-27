//
//  MainContainVC.swift
//  Extractor
//
//  Created by Jin Omori on 11/30/19.
//  Copyright © 2019 XIao Chan Lung. All rights reserved.
//

import UIKit

class MainContainVC: UITabBarController,UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == (self.tabBar.items as! [UITabBarItem])[0]{
            //Do something if index is 0
            print("test0")
            //self.se
            
        }else if item == (self.tabBar.items as! [UITabBarItem])[1]{
            //Do something if index is 1
             print("test1")
            
        }else if item == (self.tabBar.items as! [UITabBarItem])[2]{
            //Do something if index is 2
             print("test2")
            
        }
        else if item == (self.tabBar.items as! [UITabBarItem])[3]{
            //Do something if index is 3
             print("test3")
            
        }
    }
}
