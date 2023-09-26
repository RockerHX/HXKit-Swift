//
//  Xibable.swift
//  HXKit-Swift
//
//  Created by Andy Shaw on 2022/6/7.
//

import UIKit

protocol Xibable {
    static func instance(with bundle: Bundle?) -> UIView?
    static func nib(with bundle: Bundle?) -> UINib
    func xibInitialize()
}

// MARK: - Static Methods
extension Xibable where Self: UIView {

    // 获得实例以后，需要自行设置frame和addSubview
    static func instance(with bundle: Bundle? = nil) -> UIView? {
        let loadBundle = bundle ?? Bundle(for: self)
        let className = String(describing: self)
        guard let view = loadBundle.loadNibNamed(className, owner: self)?.first as? UIView else { return nil }
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return view
    }

    static func nib(with bundle: Bundle? = nil) -> UINib {
        let className = String(describing: self)
        return UINib(nibName: className, bundle: bundle ?? Bundle(for: self))
    }

    // xib初始化，需要在xib内将File’s owner设置为对应的class
    func xibInitialize() {
        guard let className = type(of: self).description().components(separatedBy: ".").last else { return }
        guard let contentView = Bundle.main.loadNibNamed(className, owner: self)?.first as? UIView else { return }
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
