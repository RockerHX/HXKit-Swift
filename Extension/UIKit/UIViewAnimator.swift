//
//  UIViewAnimator.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/8/21.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit

extension UIView {

    public class func transition(from fromView: UIView, to toView: UIView, duration: TimeInterval, options: UIViewAnimationOptions = [], completion: ((Bool) -> Swift.Void)? = nil) {
        fromView.alpha = 1
        fromView.isHidden = false
        UIView.transition(with: fromView, duration: duration, options: options, animations: {
            fromView.isHidden = true
            fromView.alpha = 0
        }, completion: nil)

        toView.alpha = 0
        toView.isHidden = true
        UIView.transition(with: toView, duration: duration, options: options, animations: {
            toView.isHidden = false
            toView.alpha = 1
        }, completion: completion)
    }

}


extension UIView {

    class Animator {

        typealias Animations = () -> Void
        typealias Completion = (Bool) -> Void

        fileprivate let duration: TimeInterval
        fileprivate let delay: TimeInterval
        fileprivate let options: UIViewAnimationOptions

        fileprivate var animations: Animations! {
            didSet {
                UIView.animate(withDuration: duration, delay: delay, options: options, animations: animations) { (success) in
                    self.completion?(success)
                    self.success = success
                }
            }
        }
        fileprivate var completion: Completion? {
            didSet {
                guard let success = success else { return }
                completion?(success)
            }
        }
        fileprivate var success: Bool?

        init(duration: TimeInterval, delay: TimeInterval = 0, options: UIViewAnimationOptions = []) {
            self.duration = duration
            self.delay = delay
            self.options = options
        }

        @discardableResult
        public func animations(animations: @escaping Animations) -> Self {
            self.animations = animations
            return self
        }

        @discardableResult
        public func completion(completion: @escaping Completion) -> Self {
            self.completion = completion
            return self
        }
    }

}


extension UIView {

    class SpringAnimator: Animator {
        
        fileprivate var dampingRatio: CGFloat
        fileprivate var velocity: CGFloat

        override fileprivate var animations: Animations! {
            didSet {
                UIView.animate(withDuration: duration, delay: delay, usingSpringWithDamping: dampingRatio, initialSpringVelocity: velocity, options: options, animations: animations) { (success) in
                    self.completion?(success)
                    self.success = success
                }
            }
        }

        init(duration: TimeInterval, delay: TimeInterval, usingSpringWithDamping dampingRatio: CGFloat, initialSpringVelocity velocity: CGFloat, options: UIViewAnimationOptions = []) {

            self.dampingRatio = dampingRatio
            self.velocity = velocity
            super.init(duration: duration, delay: delay, options: options)
        }
    }
}

