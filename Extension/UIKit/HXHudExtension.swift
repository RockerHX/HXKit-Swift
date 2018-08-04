//
//  HXHub.swift
//
//  Created by XRD.Andy on 2017/2/21.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


// Must add pod MBProgressHUD, as: pod 'MBProgressHUD'
import MBProgressHUD


extension UIViewController {

    public func showHud() {
        showHud(to: view)
    }

    public func showHud(with message: String?, afterDelay: TimeInterval = 1) {
        guard let tip = message else { return }
        showHud(with: tip, to: view, afterDelay: afterDelay)
    }

    public func hiddenHud() {
        hiddenHud(toView: view)
    }

    public func showHud(to view: UIView) {
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.white
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        hud.backgroundView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0.0, alpha: 0.8)
        hud.bezelView.style = .solidColor
    }

    public func showHud(with message: String, to view: UIView?, afterDelay: TimeInterval = 2) {
        let container = view ?? (UIApplication.shared.delegate?.window!)!
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.white
        let hud = MBProgressHUD.showAdded(to: container, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.label.textColor = .white
        hud.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        hud.backgroundView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0.0, alpha: 0.8)
        hud.bezelView.style = .solidColor
        hud.hide(animated: true, afterDelay: afterDelay)
    }

    public func hiddenHud(toView: UIView) {
        MBProgressHUD.hide(for: toView, animated: true)
    }
}
