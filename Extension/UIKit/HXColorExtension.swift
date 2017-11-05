//
//  HXColor.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/2/22.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


extension UIColor {

    static func color(withRGBHex hex: String) -> UIColor {
        var cString = hex.trimmingCharacters(in:CharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = String(cString[index...])
        }

        if (cString.count != 6) {
            return UIColor.red
        }

        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = String(cString[..<rIndex])
        let otherString = String(cString[rIndex...])
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = String(otherString[..<gIndex])
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = String(cString[bIndex...])

        var red:CUnsignedInt = 0, green:CUnsignedInt = 0, blue:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&red)
        Scanner(string: gString).scanHexInt32(&green)
        Scanner(string: bString).scanHexInt32(&blue)

        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: CGFloat(1))
    }
}
