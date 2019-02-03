//
//  HXActionSheetExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/2/27.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


// 显示上拉选择菜单Extension
extension UIViewController {

    public func showActionSheet(with title: String, message: String? = nil, otherActions: [UIAlertAction]) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        for action in otherActions {
            controller.addAction(action)
        }
        present(controller, animated: true, completion: nil)
    }

}


extension UIViewController {

    public func showAlert(with title: String, message: String? = nil, otherActions: [UIAlertAction]) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in otherActions {
            controller.addAction(action)
        }
        present(controller, animated: true, completion: nil)
    }
    
}
