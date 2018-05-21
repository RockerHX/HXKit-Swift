//
//  Console.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/5/22.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import Foundation


class Console {

    static func log<T>(message: T,
                       file: String = #file,
                       method: String = #function,
                       line: Int = #line)
    {
        debugPrint("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    }

}

