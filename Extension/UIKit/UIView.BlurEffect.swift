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

    public func toBlur(with style: UIBlurEffectStyle = .dark) {
        subviews.forEach({ (subview) in
            subview.removeFromSuperview()
        })
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = bounds
        addSubview(blurView)
    }

}


// MARK: - Instance Methods -
extension UIImageView {

    public func toBlur(with style: UIBlurEffectStyle = .dark, image: UIImage?) {
        if let addImage = image {
            self.image = addImage
            let transition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade;
            layer.add(transition, forKey: nil)
        }
        self.toBlur(with: style)
    }

}

