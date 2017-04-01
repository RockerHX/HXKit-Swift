//
//  HXClosureDecorator.swift
//
//  Created by RockerHX on 2017/2/26.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


import Foundation


final public class HXClosureDecorator<T>: NSObject {

    fileprivate let closure: Any

    fileprivate override init() {
        fatalError("Use init(action:) instead.")
    }

    public init(_ closure: @escaping (() -> ())) {
        self.closure = closure
    }

    public init(_ closure: @escaping ((T) -> ())) {
        self.closure = closure
    }

    public func invoke(_ param: T) {
        if let closure = closure as? (() -> ()) {
            closure()
        } else if let closure = closure as? ((T) -> ()) {
            closure(param)
        }
    }
}
