//
//  UIView.Kingfisher.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/2/22.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


import Kingfisher
// MARK: - Instance Methods -
extension UIImageView {

    public func showImage(with url: String, placeholder: UIImage? = nil, completionHandler: CompletionHandler? = nil) {
        guard let resource = URL(string: url) else { return }
        kf.setImage(with: resource,
             placeholder: placeholder,
                 options: [
                    .transition(ImageTransition.fade(0.5)),
                    .forceTransition,
                    .keepCurrentImageWhileLoading],
           progressBlock: nil,
       completionHandler: completionHandler)
    }

}


extension UIButton {

    public func showImage(with url: String, for state: UIControlState, placeholder: UIImage? = nil, completionHandler: CompletionHandler? = nil) {
        guard let resource = URL(string: url) else { return }
        kf.setImage(with: resource,
                     for: state,
             placeholder: placeholder,
                 options: [
                    .transition(ImageTransition.fade(0.5)),
                    .forceTransition,
                    .keepCurrentImageWhileLoading],
           progressBlock: nil,
       completionHandler: completionHandler)
    }

}

