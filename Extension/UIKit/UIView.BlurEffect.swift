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

    public func toBlur(with style: UIBlurEffect.Style = .dark) {
        self.subviews.forEach({ (subview) in
            subview.removeFromSuperview()
        })
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = self.bounds
        self.addSubview(blurView)
    }

}


// MARK: - Instance Methods -
extension UIImageView {

    public func toBlur(with style: UIBlurEffect.Style = .dark, image: UIImage?, duration: Double = 0.75) {
        self.toBlur(with: style)
        if let toImage = image , toImage != self.image {
            UIView.transition(with: self,
                              duration: duration,
                              options: .transitionCrossDissolve,
                              animations: { self.image = toImage },
                              completion: nil)
        }
    }

}

