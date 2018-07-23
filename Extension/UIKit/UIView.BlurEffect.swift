//
//  UIView.BlurEffect.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/2/22.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


// MARK: - Instance Methods -
extension UIView {

    public func toBlur(style: UIBlurEffectStyle = .dark) {
        subviews.forEach({ (subview) in
            subview.removeFromSuperview()
        })
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        addSubview(blurView)
    }

}

