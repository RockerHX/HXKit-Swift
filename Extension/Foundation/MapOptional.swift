//
//  MapOptional.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/11/27.
//  Copyright © 2018 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import Foundation


extension Optional {

    /**
    可选值变换返回，如果可选值为空，则返回默认值
    - 参数 fn: 映射值的闭包
    - 参数 default: 可选值为空时，将作为返回值

     这个方法允许你将可选值 map 成一个新的类型 T. 如果可选值为空，你可以提供一个 T 类型的默认值：
     ```
     let optional1: String? = "appventure"
     let optional2: String? = nil

     // 使用前
     debugPrint(optional1.map({ $0.count }) ?? 0)
     debugPrint(optional2.map({ $0.count }) ?? 0)

     // 使用后
     debugPrint(optional1.map({ $0.count }, default: 0)) // prints 10
     debugPrint(optional2.map({ $0.count }, default: 0)) // prints 0
     这里改动很小，我们再也不需要使用 ?? 操作符，取而代之的是更能表达意图的 default 值。
     ```
    */
    func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T {
        return try map(fn) ?? `default`
    }

}


extension Optional {

    /**
    可选值变换返回，如果可选值为空，则调用 `else` 闭包
    - 参数 fn: 映射值的闭包
    - 参数 else: The function to call if the optional is empty

     这个方法和`func map<T>(_ fn: (Wrapped) throws -> T, default: T) rethrows -> T`很相似，主要区别在于它接受（再次）返回 T 类型的闭包，而不是使用一个默认值。这里有个简单的例子：
     ```
     let optional: String? = nil
     debugPrint(optional.map({ $0.count }, else: { "default".count })
     ```
    */
    func map<T>(_ fn: (Wrapped) throws -> T, else: () throws -> T) rethrows -> T {
        return try map(fn) ?? `else`()
    }

}

