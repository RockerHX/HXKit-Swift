//
//  Array.Safe.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/7/17.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


import Foundation


extension Array {

    public subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

}

