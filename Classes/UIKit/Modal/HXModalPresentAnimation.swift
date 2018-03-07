//
//  HXModalPresentAnimation.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/3/8.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
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
    public var ratio: Double
    public var displayHeight: CGFloat

    // MARK: - Private Property -
    private var backgroundView: UIView?
    private var presented: UIViewController?

    // MARK: - Init Methods -
    public init(withDirection direction: HXMoalDirection = .bottom, duration: TimeInterval = HXModalDefaultDuration, hasMask mask: Bool = true, ratio: Double = 1.0, displayHeight: CGFloat = 0) {
        self.direction = direction
        self.duration = duration
        self.hasMask = mask

        self.ratio = (ratio >= 0 && ratio <= 1) ? ratio : 1
        self.displayHeight = (displayHeight > 0) ? displayHeight : 0
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
                        backgroundView = UIView(frame: containerView.frame)
                        containerView.addSubview(backgroundView!)
                        backgroundView?.isUserInteractionEnabled = true
                        backgroundView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backgroundTapAction)))
                        backgroundView?.backgroundColor = UIColor(white: 0.1, alpha: 0.5)
                        backgroundView?.alpha = 0.0
                        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
                            self.backgroundView?.alpha = 1.0
                        }, completion: nil)
                    }
                    
                    containerView.addSubview(toView)
                    toView.startCenter(byModalDirection: direction)

                    UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseInOut, animations: {
                        let ratio = (self.displayHeight > 0) ? Double(self.displayHeight / containerView.frame.height) : self.ratio
                        toView.endCenter(byModalDirection: self.direction, ratio: ratio)
                    }, completion: { (finished) in
                        let isCancelled = transitionContext.transitionWasCancelled
                        transitionContext.completeTransition(!isCancelled)
                    })
                }

                if fromViewController.isBeingDismissed {
                    let dissmisAnimationDuration = duration * 0.5
                    if hasMask {
                        UIView.animate(withDuration: dissmisAnimationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
                            self.backgroundView?.alpha = 0.0
                        }, completion: nil)
                    }
                    UIView.animate(withDuration: dissmisAnimationDuration, delay: 0.0, options: .curveEaseInOut, animations: {
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
            center.y = frame.height * -0.5
        case .bottom:
            center.y = frame.height * 1.5
        case .left:
            center.x = frame.width * -0.5
        case .right:
            center.x = frame.width * 1.5
        }
    }

    fileprivate func endCenter(byModalDirection direction: HXMoalDirection, ratio: Double) {

        switch direction {
        case .top:
            center.y = frame.height * CGFloat(ratio - 0.5)
        case .bottom:
            center.y = frame.height * CGFloat(1.5 - ratio)
        case .left:
            center.x = frame.width * CGFloat(ratio - 0.5)
        case .right:
            center.x = frame.width * CGFloat(1.5 - ratio)
        }
    }
}
