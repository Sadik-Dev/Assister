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

    @IBInspectable var cornerRadius: CGFloat = 0 {
           didSet {
               layer.cornerRadius = cornerRadius
               layer.masksToBounds = cornerRadius > 0
           }
       }
}
