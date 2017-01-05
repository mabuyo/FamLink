//
//  ClockHandUserView.swift
//  FamJamClock
//
//  Created by Michelle Mabuyo on 2016-10-30.
//  Copyright © 2016 Michelle Mabuyo. All rights reserved.
//

import UIKit

@IBDesignable
class ClockHandUserView: UIView {

    var userColor = UIColor.white
    var isFilled = false

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        let path = UIBezierPath(ovalIn: rect)
        userColor.setFill()
        path.fill()
    }
}
