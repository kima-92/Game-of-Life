//
//  UIButtonExtension.swift
//  Conway's Game of Life
//
//  Created by macbook on 5/29/20.
//  Copyright © 2020 WilmaRodriguez. All rights reserved.
//

import UIKit

extension UIButton {
    
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.3         // Duration of the animation
        pulse.fromValue = 0.98       // From this size
        pulse.toValue = 1.0          // To this size
        pulse.autoreverses = false   // Should it bounce back?
        pulse.repeatCount = .zero    // how many times the animation should repeat
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
}
