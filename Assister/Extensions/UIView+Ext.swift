//
//  Shake+Ext.swift
//  Assister
//
//  Created by Sana on 06/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

public extension UIView {

    func shake(count : Float = 4,for duration : TimeInterval = 0.5,withTranslation translation : Float = 5) {

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.repeatCount = count
        animation.duration = duration/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.values = [translation, -translation]
        layer.add(animation, forKey: "shake")
    }
}
