//
//  CustomTabBarItem.swift
//  Carzy
//
//  Created by ANKIT YADAV on 09/12/19.
//  Copyright © 2019 ANKIT YADAV. All rights reserved.
//

import UIKit

class CustomTabBarItem: UITabBarItem {
    //choose initial state fonts and weights here
    let normalTitleFont = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.regular)
    let selectedTitleFont = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.bold)

    //choose initial state colors here
    //let normalTitleColor = UIColor.gray
    //let selectedTitleColor = UIColor.black

    //assigns the proper initial state logic when each tab instantiates
    override func awakeFromNib() {
        super.awakeFromNib()

        //this tag # should be your primary tab's Tag*
        if self.tag == 1 {
            self.setTitleTextAttributes([NSAttributedString.Key.font: selectedTitleFont], for: UIControl.State.normal)
        } else {
            self.setTitleTextAttributes([NSAttributedString.Key.font: normalTitleFont], for: UIControl.State.normal)
        }

    }

}
