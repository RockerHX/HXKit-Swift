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


private struct InputActionAssociationKey {
    fileprivate static var completionHandlerWrapper = "com.rockerhx.UIAlertController.InputActionCompletionHandlerWrapper"
}

private extension UIAlertController {
    var completionHandlerWrapper: HXClosureDecorator<(UIAlertController, [UITextField]?)> {
        get { return associatedObject(forKey: InputActionAssociationKey.completionHandlerWrapper) as! HXClosureDecorator<(UIAlertController, [UITextField]?)> }
        set { associate(retainObject: newValue, forKey: InputActionAssociationKey.completionHandlerWrapper) }
    }
}


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

    public func showInputAlert(with title: String, message: String? = nil, completionHandler: @escaping ((UIAlertController, [UITextField]?) -> ())) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.completionHandlerWrapper = HXClosureDecorator(completionHandler)
        controller.addTextField { textField in
            textField.placeholder = "请输入要修改的内容"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel)
        let confirmAction = UIAlertAction(title: "保存", style: .destructive) { _ in
            controller.completionHandlerWrapper.invoke((controller, controller.textFields))
        }
        controller.addAction(cancelAction)
        controller.addAction(confirmAction)
        present(controller, animated: true, completion: nil)
    }
    
}
