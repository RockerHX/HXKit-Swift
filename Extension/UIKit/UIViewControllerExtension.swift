//
//  UIViewControllerExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/9/3.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


public extension UIViewController {

    @IBAction func unwindToPreviousController(_ segue: UIStoryboardSegue) {}

    @IBAction func unwindToPreviousSence(_ segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }

}


public extension UIViewController {

    func dismissKeyboard() {
        view.endEditing(true)
    }

}


import SafariServices
public extension UIViewController {

    func showSafariViewController(with source: String?) {
        guard let showURL = source,
              let url = URL(string: showURL)
        else { return }
        guard !(url.host?.isEmpty ?? true) else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationCapturesStatusBarAppearance = true
        present(safariViewController, animated: true, completion: nil)
    }

    func jump2Safari(with source: String?) {
        guard let showURL = source,
              let url = URL(string: showURL)
        else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}

