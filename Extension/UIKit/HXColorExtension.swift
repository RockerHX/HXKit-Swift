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


// MARK: - Instance Methods -
extension UIColor {

    public func toImage(with width: CGFloat = 1, height: CGFloat = 1) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else { fatalError("Color to Image Context Initialize Error!") }
        context.setFillColor(cgColor)
        context.fill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { fatalError("Color to Image Context Initialize Error!") }
        UIGraphicsEndImageContext()
        return image
    }

}


// MARK: - Static Methods -
extension UIColor {

    static func color(with hex: String, alpha: Double = 1.0) -> UIColor {
        var rgb = Int(hex.replacingOccurrences(of: "#", with: ""), radix: 16)
        rgb = rgb ?? Int(hex.replacingOccurrences(of: "0x", with: ""), radix: 16)
        return color(from: rgb ?? 0xffffff, alpha: alpha)
    }

}


extension UIColor {

    convenience init(r: Int, g: Int, b: Int, alpha: Double = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }

    static func color(from hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = (hex >> 16 ) & 0xff
        let green = (hex >> 8 ) & 0xff
        let blue = hex & 0xff
        return UIColor(r: red, g: green, b: blue, alpha: alpha)
    }

}

