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

        fileprivate var success: Bool?
        fileprivate let duration: TimeInterval

        fileprivate var animations: Animations! {
            didSet {
                UIView.animate(withDuration: duration, animations: animations) { (success) in
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

        init(duration: TimeInterval) {
            self.duration = duration
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
