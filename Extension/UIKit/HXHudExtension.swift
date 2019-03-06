//
//  HXHub.swift
//  HXKit-Swift
//
//  Created by XRD.Andy on 2017/2/21.
//  Copyright © 2017年 RockerHX. All rights reserved.
//


// Must add pod MBProgressHUD, as: pod 'MBProgressHUD'
import MBProgressHUD


extension MBProgressHUD {

    public enum Offset {
        case top
        case center
        case bottom
        case position(percent: CGFloat)

        var point: CGPoint {
            var y: CGFloat = MBProgressMaxOffset
            switch self {
            case .top:
                y = -100
            case .center:
                y = 0
            case .bottom:
                break
            case .position(let percent):
                if percent <= 1 || percent >= 0 {
                    y = (UIScreen.main.bounds.size.height / 2) * percent
                }
            }
            return CGPoint(x: 0, y: y)
        }

    }

}


extension UIViewController {

    public func showHud() {
        DispatchQueue.main.async {
            self.showHud(to: self.view)
        }
    }

    public func showHud(with message: String?, afterDelay: TimeInterval = 1, offset: MBProgressHUD.Offset = .bottom) {
        guard let tip = message else { return }
        DispatchQueue.main.async {
            self.showHud(with: tip, to: self.view, afterDelay: afterDelay, offset: offset)
        }
    }

    public func hiddenHud() {
        DispatchQueue.main.async {
            self.hiddenHud(toView: self.view)
        }
    }

    public func showHud(to view: UIView) {
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.white
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud.backgroundView.color = UIColor(white: 0.0, alpha: 0.1)
        hud.backgroundView.style = .solidColor
        hud.bezelView.color = UIColor(white: 0.0, alpha: 0.8)
        hud.bezelView.style = .solidColor
    }

    public func showHud(with message: String, to view: UIView?, afterDelay: TimeInterval = 2, offset: MBProgressHUD.Offset) {
        let container = view ?? (UIApplication.shared.delegate?.window!)!
        UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.white
        let hud = MBProgressHUD.showAdded(to: container, animated: true)
        hud.mode = .text
        hud.label.text = message
        hud.label.textColor = .white
        hud.offset = offset.point
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

