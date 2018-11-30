//
//  HXIBButtonExtension.swift
//  HXKit-Swift
//
//  Created by miaios on 16/1/20.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


extension UIButton {

    @IBInspectable var textHexColor: String {
        get {
            return "0xffffff"
        }
        set {
            setTitleColor(UIColor.color(with: newValue), for: .normal)
        }
    }
}
