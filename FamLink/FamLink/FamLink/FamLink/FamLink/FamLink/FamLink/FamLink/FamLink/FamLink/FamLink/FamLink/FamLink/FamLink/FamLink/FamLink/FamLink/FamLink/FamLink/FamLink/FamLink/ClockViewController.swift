//
//  ClockViewController.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-30.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    // clock icons
    @IBOutlet weak var clock11: UIImageView!
    @IBOutlet weak var clock12: UIImageView!
    @IBOutlet weak var clock1: UIImageView!
    @IBOutlet weak var clock2: UIImageView!
    @IBOutlet weak var clock3: UIImageView!
    @IBOutlet weak var clock4: UIImageView!
    @IBOutlet weak var clock5: UIImageView!
    @IBOutlet weak var clock6: UIImageView!
    @IBOutlet weak var clock7: UIImageView!
    @IBOutlet weak var clock8: UIImageView!
    @IBOutlet weak var clock9: UIImageView!
    @IBOutlet weak var clock10: UIImageView!
    
    // 11 o'clock hand
    @IBOutlet weak var hand11_1: ClockHandUserView!
    @IBOutlet weak var hand11_2: ClockHandUserView!
    @IBOutlet weak var hand11_3: ClockHandUserView!
    @IBOutlet weak var hand11_4: ClockHandUserView!
    @IBOutlet weak var hand11_5: ClockHandUserView!
    @IBOutlet weak var hand11_6: ClockHandUserView!
    @IBOutlet weak var hand11: UIStackView!
    
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
    
    // 4 o'clock hand
    @IBOutlet weak var hand4_1: ClockHandUserView!
    @IBOutlet weak var hand4_2: ClockHandUserView!
    @IBOutlet weak var hand4_3: ClockHandUserView!
    @IBOutlet weak var hand4_4: ClockHandUserView!
    @IBOutlet weak var hand4_5: ClockHandUserView!
    @IBOutlet weak var hand4_6: ClockHandUserView!
    @IBOutlet weak var hand4: UIStackView!
    
    // 5 o'clock hand
    @IBOutlet weak var hand5_6: ClockHandUserView!
    @IBOutlet weak var hand5_5: ClockHandUserView!
    @IBOutlet weak var hand5_4: ClockHandUserView!
    @IBOutlet weak var hand5_3: ClockHandUserView!
    @IBOutlet weak var hand5_2: ClockHandUserView!
    @IBOutlet weak var hand5_1: ClockHandUserView!
    @IBOutlet weak var hand5: UIStackView!
    
    // 6 o'clock hand
    @IBOutlet weak var hand6_6: ClockHandUserView!
    @IBOutlet weak var hand6_5: ClockHandUserView!
    @IBOutlet weak var hand6_4: ClockHandUserView!
    @IBOutlet weak var hand6_3: ClockHandUserView!
    @IBOutlet weak var hand6_2: ClockHandUserView!
    @IBOutlet weak var hand6_1: ClockHandUserView!
    @IBOutlet weak var hand6: UIStackView!
    
    // 7 o'clock hand
    @IBOutlet weak var hand7_6: ClockHandUserView!
    @IBOutlet weak var hand7_5: ClockHandUserView!
    @IBOutlet weak var hand7_4: ClockHandUserView!
    @IBOutlet weak var hand7_3: ClockHandUserView!
    @IBOutlet weak var hand7_2: ClockHandUserView!
    @IBOutlet weak var hand7_1: ClockHandUserView!
    @IBOutlet weak var hand7: UIStackView!
    
    // 8 o'clock hand
    @IBOutlet weak var hand8_1: ClockHandUserView!
    @IBOutlet weak var hand8_2: ClockHandUserView!
    @IBOutlet weak var hand8_3: ClockHandUserView!
    @IBOutlet weak var hand8_4: ClockHandUserView!
    @IBOutlet weak var hand8_5: ClockHandUserView!
    @IBOutlet weak var hand8_6: ClockHandUserView!
    @IBOutlet weak var hand8: UIStackView!
    
    // 9 o'clock hand
    @IBOutlet weak var hand9_1: ClockHandUserView!
    @IBOutlet weak var hand9_2: ClockHandUserView!
    @IBOutlet weak var hand9_3: ClockHandUserView!
    @IBOutlet weak var hand9_4: ClockHandUserView!
    @IBOutlet weak var hand9_5: ClockHandUserView!
    @IBOutlet weak var hand9_6: ClockHandUserView!
    @IBOutlet weak var hand9: UIStackView!
    
    // 10 o'clock hand
    @IBOutlet weak var hand10_1: ClockHandUserView!
    @IBOutlet weak var hand10_2: ClockHandUserView!
    @IBOutlet weak var hand10_3: ClockHandUserView!
    @IBOutlet weak var hand10_4: ClockHandUserView!
    @IBOutlet weak var hand10_5: ClockHandUserView!
    @IBOutlet weak var hand10_6: ClockHandUserView!
    @IBOutlet weak var hand10: UIStackView!
    
    var hands: [[ClockHandUserView?]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hands = [
            [], // just so it's not zero-indexed
            [hand1_1, hand1_2, hand1_3, hand1_4, hand1_5, hand1_6],
            [hand2_1, hand2_2, hand2_3, hand2_4, hand2_5, hand2_6],
            [hand3_1, hand3_2, hand3_3, hand3_4, hand3_5, hand3_6],
            [hand4_1, hand4_2, hand4_3, hand4_4, hand4_5, hand4_6],
            [hand5_1, hand5_2, hand5_3, hand5_4, hand5_5, hand5_6],
            [hand6_1, hand6_2, hand6_3, hand6_4, hand6_5, hand6_6],
            [hand7_1, hand7_2, hand7_3, hand7_4, hand7_5, hand7_6],
            [hand8_1, hand8_2, hand8_3, hand8_4, hand8_5, hand8_6],
            [hand9_1, hand9_2, hand9_3, hand9_4, hand9_5, hand9_6],
            [hand10_1, hand10_2, hand10_3, hand10_4, hand10_5, hand10_6],
            [hand11_1, hand11_2, hand11_3, hand11_4, hand11_5, hand11_6],
            [hand12_1, hand12_2, hand12_3, hand12_4, hand12_5, hand12_6]
        ]
        
        var colors = [
            UIColor.blue,
            UIColor.red,
            UIColor.green,
            UIColor.black,
            UIColor.orange,
            UIColor.brown,
            UIColor.cyan,
            UIColor.magenta,
            UIColor.purple,
            UIColor.yellow,
            UIColor.cyan,
            UIColor.green
        ]
        
        // clock colors
        for i in 0...hands.count-1 {
            for hand in hands[i] {
                //hand?.userColor = colors[i]
                hand?.userColor = UIColor.darkGray
            }
            
//            self.hands[i][0]?.userColor = UIColor.darkGray
        }
        
        // clock hand, set angles
        hand11.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 6)
        hand1.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
        hand2.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 6)
        hand4.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
        hand5.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 6)
        hand7.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
        hand8.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 6)
        hand10.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 6)
        
        // get locations from data source
        var clock_icons = [Int: UIImageView]()
        clock_icons[1] = clock1
        clock_icons[2] = clock2
        clock_icons[3] = clock3
        clock_icons[4] = clock4
        clock_icons[5] = clock5
        clock_icons[6] = clock6
        clock_icons[7] = clock7
        clock_icons[8] = clock8
        clock_icons[9] = clock9
        clock_icons[10] = clock10
        clock_icons[11] = clock11
        clock_icons[12] = clock12
        
        let locations = LocationsDataSource().locations
        for location in locations {
            let clock_icon = clock_icons[location.number]
            clock_icon?.image = location.icon
        }
        
        setUserLocations()
    }
    
    func setUserLocations() {
        let user_locations = FamLinkClock.sharedInstance.users
        
        print("\(user_locations)")
        
        for (user, location) in user_locations {
            let clock_pos = getClockPosition(fromLocationName: location)
            
            print("clock position: \(clock_pos)")
            
            if clock_pos != -1 {
                for pos in hands[clock_pos] {
                    if !(pos?.isFilled)! {
                        let color = FamLinkClock.sharedInstance.user_colors[user]
                        pos?.isFilled = true
                        break;
                    }
                }
            }
        }
        
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

extension ClockViewController {
    
    func getClockPosition(fromLocationName: String) -> Int{
        for location in LocationsDataSource().locations {
            if location.name == fromLocationName {
                return location.number
            }
        }
        
        return -1
    }
}
