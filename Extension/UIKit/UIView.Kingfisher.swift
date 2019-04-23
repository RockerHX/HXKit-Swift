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

    public func showImage(with url: URL?, placeholder: UIImage? = nil, animation: Bool = false, completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        let options: KingfisherOptionsInfo = animation ? [
            .transition(ImageTransition.fade(0.5)),
            .forceTransition,
            .keepCurrentImageWhileLoading] : []
        kf.setImage(with: url,
             placeholder: placeholder,
                 options: options,
           progressBlock: nil,
       completionHandler: completionHandler)
    }

}


extension UIButton {

    public func showImage(with url: URL?, for state: UIControl.State, placeholder: UIImage? = nil, animation: Bool = false , completionHandler: ((Result<RetrieveImageResult, KingfisherError>) -> Void)? = nil) {
        let options: KingfisherOptionsInfo = animation ? [
            .transition(ImageTransition.fade(0.5)),
            .forceTransition,
            .keepCurrentImageWhileLoading] : []
        kf.setImage(with: url,
                     for: state,
             placeholder: placeholder,
                 options: options,
           progressBlock: nil,
       completionHandler: completionHandler)
    }

}

