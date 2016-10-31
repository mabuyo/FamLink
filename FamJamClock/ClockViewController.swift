//
//  ClockViewController.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-30.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    // 12 o'clock hand
    @IBOutlet weak var hand12: UIStackView!
    @IBOutlet weak var hand12_1: ClockHandUserView!
    @IBOutlet weak var hand12_2: ClockHandUserView!
    @IBOutlet weak var hand12_3: ClockHandUserView!
    @IBOutlet weak var hand12_4: ClockHandUserView!
    @IBOutlet weak var hand12_5: ClockHandUserView!
    @IBOutlet weak var hand12_6: ClockHandUserView!
    
    // 1 o'clock hand
    @IBOutlet weak var hand1: UIStackView!
    @IBOutlet weak var hand1_1: ClockHandUserView!
    @IBOutlet weak var hand1_2: ClockHandUserView!
    @IBOutlet weak var hand1_3: ClockHandUserView!
    @IBOutlet weak var hand1_4: ClockHandUserView!
    @IBOutlet weak var hand1_5: ClockHandUserView!
    @IBOutlet weak var hand1_6: ClockHandUserView!
    
    // 2 o'clock hand
    @IBOutlet weak var hand2_1: ClockHandUserView!
    @IBOutlet weak var hand2_2: ClockHandUserView!
    @IBOutlet weak var hand2_3: ClockHandUserView!
    @IBOutlet weak var hand2_4: ClockHandUserView!
    @IBOutlet weak var hand2_5: ClockHandUserView!
    @IBOutlet weak var hand2_6: ClockHandUserView!
    @IBOutlet weak var hand2: UIStackView!
    
    // 3 o'clock hand
    @IBOutlet weak var hand3: UIStackView!
    @IBOutlet weak var hand3_1: ClockHandUserView!
    @IBOutlet weak var hand3_2: ClockHandUserView!
    @IBOutlet weak var hand3_3: ClockHandUserView!
    @IBOutlet weak var hand3_4: ClockHandUserView!
    @IBOutlet weak var hand3_5: ClockHandUserView!
    @IBOutlet weak var hand3_6: ClockHandUserView!
    
   
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hands = [
            [hand12_1, hand12_2, hand12_3, hand12_4, hand12_5, hand12_6],
            [hand1_1, hand1_2, hand1_3, hand1_4, hand1_5, hand1_6],
            [hand2_1, hand2_2, hand2_3, hand2_4, hand2_5, hand2_6],
            [hand3_1, hand3_2, hand3_3, hand3_4, hand3_5, hand3_6]
        ]
        
        for hand in hands[0] {
            hand?.userColor = UIColor.blue
        }
        hands[0][0]?.userColor = UIColor.darkGray
        
        for hand in hands[1] {
            hand?.userColor = UIColor.red
        }
        hands[1][0]?.userColor = UIColor.darkGray

        for hand in hands[2] {
            hand?.userColor = UIColor.orange
        }
        hands[2][0]?.userColor = UIColor.darkGray

        for hand in hands[3] {
            hand?.userColor = UIColor.green
        }
        hands[3][0]?.userColor = UIColor.darkGray

        
        // angles
        hand1.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
        hand2.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 6)
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
