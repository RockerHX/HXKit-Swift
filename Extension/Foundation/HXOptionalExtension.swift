//
//  HXOptionalExtension.swift
//  News
//
//  Created by RockerHX on 2018/3/12.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


import Foundation


// MARK: - Integer Literal Type -
extension Optional where Wrapped == IntegerLiteralType {

    var string: String? {
        switch self {
        case .some(let value):
            return String(value)
        default:
            return nil
        }
    }

}
}


// MARK: - Float Literal Type -
extension Optional where Wrapped == FloatLiteralType {

    var string: String? {
        switch self {
        case .some(let value):
            return String(value)
        default:
            return nil
        }
    }

}


// MARK: - String Literal Type -
extension Optional where Wrapped == StringLiteralType {

    var int: Int? {
        switch self {
        case .some(let value):
            return Int(value)
        default:
            return nil
        }
    }

    var double: Double? {
        switch self {
        case .some(let value):
            return Double(value)
        default:
            return nil
        }
    }

    var float: Float? {
        switch self {
        case .some(let value):
            return Float(value)
        default:
            return nil
        }
    }

}


