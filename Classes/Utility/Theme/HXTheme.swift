//
//  HXTheme.swift
//  HXKit-Swift
//
//  Created by ShiCang on 16/5/25.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


let SelectedThemeKey = "SelectedTheme"


struct HXTheme {

    enum Theme {
        case `default`, dark, graphical
        case custom(with: UIColor)

        var color: UIColor {
            switch self {
            case .`default`:
                return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
            case .dark:
                return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
            case .graphical:
                return .red
            case .custom(let color):
                return color
            }
        }

        var tintColor: UIColor {
            return .white
        }

        var value: String {
            return CIColor(cgColor: color.cgColor).stringRepresentation
        }

        static func instance(with key: String) -> Theme {
            let components = key.components(separatedBy: " ")
            let red = CGFloat(Double(components[0])!)
            let green = CGFloat(Double(components[1])!)
            let blue = CGFloat(Double(components[2])!)
            let alpha = CGFloat(Double(components[3])!)
            let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
            return .custom(with: color)
        }
    }
    
    static func current() -> Theme {
        if let key = UserDefaults.standard.string(forKey: SelectedThemeKey) {
            return Theme.instance(with: key)
        } else {
            return .default
        }
    }

    static func apply(whtiTheme theme: Theme) {
        UserDefaults.standard.set(theme.value, forKey: SelectedThemeKey)
        UserDefaults.standard.synchronize()

        let color = theme.color
        let tintColor = theme.tintColor
        let application = UIApplication.shared
        application.delegate?.window??.tintColor = color
        UINavigationBar.appearance().barTintColor = color
        UINavigationBar.appearance().tintColor = tintColor
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: tintColor]
    }

}

