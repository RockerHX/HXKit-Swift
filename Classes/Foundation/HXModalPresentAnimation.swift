//
//  HXModalPresentAnimation.swift
//  XRDLoanServices
//
//  Created by RockerHX on 2017/3/8.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


import UIKit


enum HXMoalDirection {
    case top
    case bottom
    case left
    case right
}


fileprivate let HXModalDefaultDuration: TimeInterval = 0.5


class HXModalPresentAnimation: NSObject, UIViewControllerAnimatedTransitioning {

    // MARK: - Public Property -
    public var direction: HXMoalDirection {
        get {
            return modalDirection
        }
    }

    public var duration: TimeInterval {
        get {
            return transitionDuration
        }
    }
    public var hasMask: Bool

    // MARK: - Private Methods -
    fileprivate var modalDirection: HXMoalDirection
    fileprivate var transitionDuration: TimeInterval

    // MARK: - Init Methods -
    public init(withDirection direction: HXMoalDirection = .bottom, duration: TimeInterval = HXModalDefaultDuration, hasMask mask: Bool = true) {
        self.modalDirection = direction
        self.transitionDuration = duration
        self.hasMask = mask
    }

    // MARK: - UIViewControllerAnimatedTransitioning -
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        if let toViewController = transitionContext.viewController(forKey: .to), let fromViewController = transitionContext.viewController(forKey: .from) {

            if let toView = toViewController.view, let fromView = fromViewController.view {
                let containerView = transitionContext.containerView
                let duration = transitionDuration(using: transitionContext)

                if toViewController.isBeingPresented {
                    containerView.addSubview(toView)
                    toView.startCenter(byModalDirection: direction)

                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
                        toView.endCenter(byModalDirection: self.direction)
                    }, completion: { (finished) in
                        let isCancelled = transitionContext.transitionWasCancelled
                        transitionContext.completeTransition(!isCancelled)

                        if self.hasMask {
                            UIView.animate(withDuration: 0.2, animations: {
                                containerView.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
                            }, completion: nil)
                        }
                    })
                }

                if fromViewController.isBeingDismissed {
                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
                        fromView.startCenter(byModalDirection: self.direction)
                    }, completion: { (finished) in
                        let isCancelled = transitionContext.transitionWasCancelled
                        transitionContext.completeTransition(!isCancelled)
                    })
                }
            }
        }
    }
}


extension UIView {

    fileprivate func startCenter(byModalDirection direction: HXMoalDirection) {

        switch direction {
        case .top:
            center.y = CGFloat(frame.height * Double(-1.5))
        case .bottom:
            center.y = CGFloat(frame.height * Double(1.5))
        case .left:
            center.x = CGFloat(frame.width * Double(-1.5))
        case .right:
            center.x = CGFloat(frame.width * Double(1.5))
        }
    }

    fileprivate func endCenter(byModalDirection direction: HXMoalDirection) {

        switch direction {
        case .top, .bottom:
            center.y = CGFloat(fabs(center.y / 3))
        case .left, .right:
            center.x = CGFloat(fabs(center.x / 3))
        }
    }
}
