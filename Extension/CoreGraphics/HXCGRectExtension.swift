//
//  RectExtension.swift
//
//  Created by XRD.Andy on 2017/2/10.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


import UIKit


extension CGRect {

    var x: Double {
        get {
            return Double(origin.x)
        }

        set {
            self.origin.x = CGFloat(newValue)
        }
    }

    var y: Double {
        get {
            return Double(origin.y)
        }

        set {
            self.origin.y = CGFloat(newValue)
        }
    }

    var width: Double {
        get {
            return Double(size.width)
        }

        set {
            self.size.width = CGFloat(newValue)
        }
    }

    var height: Double {
        get {
            return Double(size.height)
        }

        set {
            self.size.height = CGFloat(newValue)
        }
    }
}
