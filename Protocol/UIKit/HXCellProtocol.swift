//
//  HXCellProtocol.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/3/6.
//  Copyright © 2018年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


protocol HXCellProtocol {
    static func identifier() -> String
}


extension HXCellProtocol {

    static func identifier() -> String {
        return String(describing: self.self)
    }
}

