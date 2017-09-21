//
//  HXModalPresentAnimation.swift
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
    private(set) var direction: HXMoalDirection
    private(set) var duration: TimeInterval
    public var hasMask: Bool
    public var ratio: Float

    // MARK: - Private Property -
    private var presented: UIViewController?

    // MARK: - Init Methods -
    public init(withDirection direction: HXMoalDirection = .bottom, duration: TimeInterval = HXModalDefaultDuration, hasMask mask: Bool = true, ratio: Float = 1.0) {
        self.direction = direction
        self.duration = duration
        self.hasMask = mask

        if ratio >= 0 && ratio <= 1 {
            self.ratio = ratio
        } else {
            self.ratio = 1.0
        }
    }

    // MARK: - Private Methods -
    @objc private func backgroundTapAction() {
        presented?.dismiss(animated: true, completion: nil)
    }

    // MARK: - UIViewControllerAnimatedTransitioning -
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        if let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) {

            presented = toViewController
            if let toView = toViewController.view, let fromView = fromViewController.view {
                let containerView = transitionContext.containerView
                let duration = transitionDuration(using: transitionContext)

                if toViewController.isBeingPresented {
                    if hasMask {
                        let backgroundView = UIView(frame: containerView.frame)
                        containerView.addSubview(backgroundView)
                        backgroundView.isUserInteractionEnabled = true
                        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapAction)))
                        backgroundView.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
                        backgroundView.alpha = 0.0
                        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
                            backgroundView.alpha = 1.0
                        }, completion: nil)
                    }
                    
                    containerView.addSubview(toView)
                    toView.startCenter(byModalDirection: direction)

                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
                        toView.endCenter(byModalDirection: self.direction, ratio: self.ratio)
                    }, completion: { (finished) in
                        let isCancelled = transitionContext.transitionWasCancelled
                        transitionContext.completeTransition(!isCancelled)
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

    fileprivate func endCenter(byModalDirection direction: HXMoalDirection, ratio: Float) {

        switch direction {
        case .top, .bottom:
            center.y = CGFloat(fabs(center.y / CGFloat(3 * ratio)))
        case .left, .right:
            center.x = CGFloat(fabs(center.x / CGFloat(3 * ratio)))
        }
    }
}
