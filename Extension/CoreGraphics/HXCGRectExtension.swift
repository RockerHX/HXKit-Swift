//
//  RectExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/2/10.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


extension CGRect {

    var x: CGFloat {
        get {
            return CGFloat(origin.x)
        }

        set {
            self.origin.x = CGFloat(newValue)
        }
    }

    var y: CGFloat {
        get {
            return CGFloat(origin.y)
        }

        set {
            self.origin.y = CGFloat(newValue)
        }
    }

    var width: CGFloat {
        get {
            return CGFloat(size.width)
        }

        set {
            self.size.width = CGFloat(newValue)
        }
    }

    var height: CGFloat {
        get {
            return CGFloat(size.height)
        }

        set {
            self.size.height = CGFloat(newValue)
        }
    }
}
