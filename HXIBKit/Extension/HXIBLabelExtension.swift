//
//  HXIBLabelExtension.swift
//  EShop
//
//  Created by miaios on 16/1/20.
//  Copyright © 2016年 Cave. All rights reserved.
//


import UIKit


extension UILabel {

    @IBInspectable var textHexColor: String {
        get {
            return "0xffffff";
        }
        set {
            textColor = UIColor.color(withRGBHex: newValue)
        }
    }
}
