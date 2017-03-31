//
//  HXIBButtonExtension.swift
//  EShop
//
//  Created by miaios on 16/1/20.
//  Copyright © 2016年 Cave. All rights reserved.
//


import UIKit


extension UIButton {

    @IBInspectable var textHexColor: String {
        get {
            return "0xffffff";
        }
        set {
            setTitleColor(UIColor.color(withRGBHex: newValue), for: .normal)
        }
    }
}
