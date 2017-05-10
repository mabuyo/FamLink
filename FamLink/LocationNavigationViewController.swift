//
//  LocationNavigationViewController.swift
//  FamLink
//
//  Created by Michelle Mabuyo on 2017-03-04.
//  Copyright © 2017 Michelle Mabuyo. All rights reserved.
//

import UIKit

class LocationNavigationViewController: UINavigationController {
    let bgColor = UIColor(red: 86/255.0, green: 85/255.0, blue: 84/255.0, alpha: 1)
    let textColor = UIColor(red: 249/255.0, green: 207/255.0, blue: 81/255.0, alpha: 1)

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.navigationBar.barTintColor = self.bgColor
        let font = UIFont(name: "Nunito", size: 22)
        self.navigationBar.titleTextAttributes = [
                NSForegroundColorAttributeName: self.textColor,
                NSFontAttributeName: font!
            ]
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
