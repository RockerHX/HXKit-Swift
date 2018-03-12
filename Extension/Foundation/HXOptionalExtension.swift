//
//  HXOptionalExtension.swift
//  News
//
//  Created by RockerHX on 2018/3/12.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


import Foundation


extension Optional where Wrapped == Int {

    var string: String? {
        if let value = self?.hashValue {
            return String(value)
        }
        return nil
    }
}


extension Optional where Wrapped == Double {

    var string: String? {
        if let value = self?.hashValue {
            return String(value)
        }
        return nil
    }
}


extension Optional where Wrapped == Float {

    var string: String? {
        if let value = self?.hashValue {
            return String(value)
        }
        return nil
    }
}


extension Optional where Wrapped == String {

    var int: Int? {
        if let value = self?.hashValue {
            return Int(value)
        }
        return nil
    }

    var double: Double? {
        if let value = self?.hashValue {
            return Double(value)
        }
        return nil
    }

    var float: Float? {
        if let value = self?.hashValue {
            return Float(value)
        }
        return nil
    }
}


