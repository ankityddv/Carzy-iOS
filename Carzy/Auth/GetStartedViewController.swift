//
//  GetStartedViewController.swift
//  Carzy
//
//  Created by ANKIT YADAV on 23/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit

class GetStartedViewController: UIViewController {
    
    @IBOutlet weak var getStartedBttn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getStartedBttn.layer.cornerRadius = 10
        overrideUserInterfaceStyle = .light
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden=true
    }
    

}
