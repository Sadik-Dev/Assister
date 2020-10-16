//
//  RoundedCornerView.swift
//  Assister
//
//  Created by Sana on 16/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornerView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    @IBInspectable var cornerRadius: CGFloat = 0 {
           didSet {
               layer.cornerRadius = cornerRadius
               layer.masksToBounds = cornerRadius > 0
           }
       }
}
