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

    public func showImage(with url: String, placeholder: UIImage? = nil, animation: Bool = false, completionHandler: CompletionHandler? = nil) {
        guard let resource = URL(string: url) else { return }
        let options: KingfisherOptionsInfo = animation ? [
            .transition(ImageTransition.fade(0.5)),
            .forceTransition,
            .keepCurrentImageWhileLoading] : []
        kf.setImage(with: resource,
             placeholder: placeholder,
                 options: options,
           progressBlock: nil,
       completionHandler: completionHandler)
    }

}


extension UIButton {

    public func showImage(with url: String, for state: UIControlState, placeholder: UIImage? = nil, animation: Bool = false , completionHandler: CompletionHandler? = nil) {
        guard let resource = URL(string: url) else { return }
        let options: KingfisherOptionsInfo = animation ? [
            .transition(ImageTransition.fade(0.5)),
            .forceTransition,
            .keepCurrentImageWhileLoading] : []
        kf.setImage(with: resource,
                     for: state,
             placeholder: placeholder,
                 options: options,
           progressBlock: nil,
       completionHandler: completionHandler)
    }

}

