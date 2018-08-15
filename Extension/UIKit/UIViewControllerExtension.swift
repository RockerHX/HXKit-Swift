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

    @IBAction public func unwindToPreviousController(_ segue: UIStoryboardSegue) {}

    @IBAction public func unwindToPreviousSence(_ segue: UIStoryboardSegue) {
        self.dismiss(animated: true, completion: nil)
    }

}


public extension UIViewController {

    public func dismissKeyboard() {
        view.endEditing(true)
    }

}


import SafariServices
public extension UIViewController {

    public func showSafariViewController(with source: String?) {
        guard let showURL = source,
            let url = URL(string: showURL)
            else { return }
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.modalPresentationCapturesStatusBarAppearance = true
        present(safariViewController, animated: true, completion: nil)
    }

}


extension SFSafariViewController {

    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.statusBarStyle = .lightContent
    }

}

