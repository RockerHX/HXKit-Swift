//
//  HXMessage.swift
//  HXKit-Swift
//
//  Created by XRD.Andy on 2017/2/20.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


// Must add pod SwiftMessages, as: pod 'SwiftMessages'
import SwiftMessages


enum HXMessage: String {
    case info    = "友情提示！"
    case success = "你好棒棒！"
    case warning = "友情警告！"
    case error   = "严重警告！"
    
    var title: String {
        get {
            return self.rawValue
        }
    }
}


extension UIViewController {

    func showMessage(_ theme: Theme, message: String?) {
        if let content = message {
            switch theme {
            case .info:
                let info = MessageView.viewFromNib(layout: .messageView)
                info.configureTheme(.info)
                info.button?.isHidden = true
                info.configureContent(title: HXMessage.info.title, body: content)
                var infoConfig = SwiftMessages.defaultConfig
                infoConfig.duration = .seconds(seconds: 0.25)
                SwiftMessages.show(config: infoConfig, view: info)
            case .success:
                let success = MessageView.viewFromNib(layout: .cardView)
                success.configureTheme(.success)
                success.configureDropShadow()
                success.configureContent(title: HXMessage.success.title, body: content)
                success.button?.isHidden = true
                
                var successConfig = SwiftMessages.defaultConfig
                successConfig.presentationContext = .window(windowLevel: UIWindow.Level.normal)
                SwiftMessages.show(config: successConfig, view: success)
            case .warning:
                let warning = MessageView.viewFromNib(layout: .cardView)
                warning.configureTheme(.warning)
                warning.configureDropShadow()
                
                let iconText = "🤔"
                warning.configureContent(title: HXMessage.warning.title, body: content, iconText: iconText)
                warning.button?.isHidden = true
                
                var warningConfig = SwiftMessages.defaultConfig
                warningConfig.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
                SwiftMessages.show(config: warningConfig, view: warning)
            case .error:
                let error = MessageView.viewFromNib(layout: .tabView)
                error.configureTheme(.error)
                error.configureContent(title: HXMessage.error.title, body: content)
                error.button?.setTitle("Stop", for: .normal)
                SwiftMessages.show(view: error)
            }
        }
    }
}
