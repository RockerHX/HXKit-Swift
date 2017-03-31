//
//  HXActionSheetExtension.swift
//  XRDLoanServices
//
//  Created by RockerHX on 2017/2/27.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


import UIKit


// 显示上拉选择菜单Extension
extension UIViewController {

    public func showActionSheet(withTitle title: String, message: String? = nil, otherActions: Array<UIAlertAction>) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in otherActions {
            alertController.addAction(action)
        }

        present(alertController, animated: true, completion: nil)
    }
}
