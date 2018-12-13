//
//  ModalViewController.swift
//  FishHead
//
//  Created by RockerHX on 2018/8/24.
//  Copyright © 2018年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


class ModalViewController: UIViewController {

    // MARK: - IBOutlet Property -
    // MARK: - Public Property -
    public var animation = HXModalPresentAnimation(duration: 0.35)

    // MARK: - Private Property -
    // MARK: - View Controller Life Cycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    // MARK: - Override Methods -
    // MARK: - Configuration Methods -
    private func configure() {
    }
    
}


// MARK: - Event Methods -
extension ModalViewController {
}


// MARK: - Public Methods -
extension ModalViewController {
}


// MARK: - Private Methods -
extension ModalViewController {
}


// MARK: - UIViewControllerTransitioningDelegate -
extension ModalViewController: UIViewControllerTransitioningDelegate {

    private func presentAnimation(forPresented presented: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animation
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation(forPresented: presented)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation(forPresented: dismissed)
    }

}

