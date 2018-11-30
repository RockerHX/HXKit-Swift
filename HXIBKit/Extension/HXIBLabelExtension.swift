//
//  HXIBLabelExtension.swift
//  HXKit-Swift
//
//  Created by miaios on 16/1/20.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


extension UILabel {

    @IBInspectable var textHexColor: String {
        get {
            return "0xffffff"
        }
        set {
            textColor = UIColor.color(with: newValue)
        }
    }

}

