//
//  BaseTabBarController.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2017-02-20.
//  Copyright © 2017 Michelle Mabuyo. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    let defaultIndex = 1
    let bgColor = UIColor(red: 86/255.0, green: 85/255.0, blue: 84/255.0, alpha: 1)
    let sColor = UIColor(red: 250/255.0, green: 240/255.0, blue: 202/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = defaultIndex
        
        //self.tabBar.barTintColor = self.bgColor
        //self.tabBar.tintColor = self.sColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
