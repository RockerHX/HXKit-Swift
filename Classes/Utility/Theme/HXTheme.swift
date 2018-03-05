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

    enum Theme: Int {
        case `default`, dark, graphical

        var color: UIColor {
            switch self {
            case .`default`:
                return UIColor(red: 87.0/255.0, green: 188.0/255.0, blue: 95.0/255.0, alpha: 1.0)
            case .dark:
                return UIColor(red: 242.0/255.0, green: 101.0/255.0, blue: 34.0/255.0, alpha: 1.0)
            case .graphical:
                return .red
            }
        }

        var tintColor: UIColor {
            return .white
        }
    }
    
    static func current() -> Theme {
        let storedThemeIndex = UserDefaults.standard.integer(forKey: SelectedThemeKey)
        if let theme = Theme(rawValue: storedThemeIndex) {
            return theme
        } else {
            return .default
        }
    }

    static func apply(whtiTheme theme: Theme) {
        UserDefaults.standard.set(theme.rawValue, forKey: SelectedThemeKey)
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

