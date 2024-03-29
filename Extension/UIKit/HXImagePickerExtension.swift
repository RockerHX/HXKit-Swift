//
//  HXImagePickerExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/2/27.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


private struct ImagePickerAssociationKey {
    fileprivate static var completionHandlerWrapper = "com.rockerhx.UIImagePickerController.imagePickerCompletionHandlerWrapper"
}

private extension UIImagePickerController {
    var completionHandlerWrapper: HXClosureDecorator<(UIImagePickerController, UIImage?)> {
        get { return associatedObject(forKey: ImagePickerAssociationKey.completionHandlerWrapper) as! HXClosureDecorator<(UIImagePickerController, UIImage?)> }
        set { associate(retainObject: newValue, forKey: ImagePickerAssociationKey.completionHandlerWrapper) }
    }
}

// 调用系统相机Extension
/*
 必须在Info.plist里添加相应权限
 <key>NSPhotoLibraryUsageDescription</key>
 <string>我们需要访问您的相册</string>
 <key>NSCameraUsageDescription</key>
 <string>我们需要访问您的相机</string>
 */
extension UIViewController {

    public func showImagePickerActionSheet(canEdit: Bool = false, completionHandler: @escaping ((UIImagePickerController, UIImage?) -> ())) {
        let cameraAction = UIAlertAction(title: "相机", style: .default, handler: { [weak self] (action) in
            self?.presentImagePickerController(withSourceType: .camera, allowsEditing: canEdit, completionHandler: completionHandler)
        })
        let photoLibraryAction = UIAlertAction(title: "图库", style: .default, handler: { [weak self] (action) in
            self?.presentImagePickerController(withSourceType: .photoLibrary, allowsEditing: canEdit, completionHandler: completionHandler)
        })
        let photosAlbumAction = UIAlertAction(title: "相片库", style: .default, handler: { [weak self] (action) in
            self?.presentImagePickerController(withSourceType: .savedPhotosAlbum, allowsEditing: canEdit, completionHandler: completionHandler)
        })
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler:nil)

        showActionSheet(with: "请选择图片来源", otherActions: [cameraAction, photoLibraryAction, photosAlbumAction, cancelAction])
    }

    public func presentImagePickerController(withSourceType type: UIImagePickerController.SourceType, allowsEditing: Bool, completionHandler: @escaping ((UIImagePickerController, UIImage?) -> ())) {
        var message: String? = nil
        if !UIImagePickerController.isSourceTypeAvailable(type) {
            switch type {
            case .camera:
                message = "你确认你的手机里有摄像头？？？"
            case .photoLibrary:
                message = "你确认你的手机里有图库？？？"
            case .savedPhotosAlbum:
                message = "你确认你的手机里有相片库？？？"
            @unknown default:
                fatalError()
            }
            assert(message != nil, message!)
        } else {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = type
            picker.allowsEditing = allowsEditing
            picker.completionHandlerWrapper = HXClosureDecorator(completionHandler)

            present(picker, animated: true, completion: nil)
        }
    }

}


extension UIViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        var infoKey: UIImagePickerController.InfoKey = .originalImage
        if picker.allowsEditing {
            infoKey = UIImagePickerController.InfoKey.editedImage
        }
        let image = info[infoKey] as? UIImage
        picker.completionHandlerWrapper.invoke((picker, image))
        imagePickerControllerDidCancel(picker)
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}

