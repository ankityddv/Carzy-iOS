//
//  CustomTabBarViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 09/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit

class CustomTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillLayoutSubviews() {
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = 50
        tabFrame.origin.y = self.view.frame.size.height - 50
        self.tabBar.frame = tabFrame
    }
    

}
