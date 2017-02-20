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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedIndex = defaultIndex

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
