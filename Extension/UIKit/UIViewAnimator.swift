//
//  UIViewAnimator.swift
//
//  Created by RockerHX on 2017/8/21.
//  Copyright © 2017年 RockerHX. All rights reserved.
//


import UIKit


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

        public func animations(animations: @escaping Animations) -> Self {
            self.animations = animations
            return self
        }

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