//
//  HXHub.swift
//  XRDLoanServices
//
//  Created by XRD.Andy on 2017/2/21.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


// Must add pod MBProgressHUD, as: pod 'MBProgressHUD'
import MBProgressHUD


extension UIViewController {

    func showHud() {
        showHud(toView: view)
    }

    func hiddenHud() {
        hiddenHud(toView: view)
    }

    func showHud(toView: UIView) {
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.white
        let hud = MBProgressHUD.showAdded(to: toView, animated: true)
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        hud.backgroundView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0.0, alpha: 0.8)
        hud.bezelView.style = .solidColor
    }

    func hiddenHud(toView: UIView) {
        MBProgressHUD.hide(for: toView, animated: true)
    }
}
