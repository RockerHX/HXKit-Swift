//
//  HXXibView.swift
//  HXKit-Swift
//
//  Created by miaios on 16/1/19.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


@IBDesignable class HXXibView: UIView {

    var view: UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)

        xibSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        xibSetup()
    }

    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]

        addSubview(view)
    }

    func loadViewFromNib() -> UIView? {
        var view: UIView?
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let objects = nib.instantiate(withOwner: self, options: nil)
        objects.forEach { (object) in
            if let objectView = object as? UIView {
                view = objectView
            }
        }
        return view
    }

}

