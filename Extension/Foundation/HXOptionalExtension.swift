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


extension Optional where Wrapped == IntegerLiteralType {

    static func + (left: Optional<Wrapped>, right: Optional<Wrapped>) -> Wrapped {
        return left + right
    }

    static func + (left: Optional<Wrapped>, right: Wrapped) -> Wrapped {
        if let value = left {
            return value + right
        }
        return right
    }

    static func + (left: Wrapped, right: Optional<Wrapped>) -> Wrapped {
        if let value = right {
            return left + value
        }
        return left
    }

}


extension Optional where Wrapped == IntegerLiteralType {

    static func - (left: Optional<Wrapped>, right: Optional<Wrapped>) -> Wrapped {
        return left - right
    }

    static func - (left: Optional<Wrapped>, right: Wrapped) -> Wrapped {
        if let value = left {
            return value - right
        }
        return -right
    }

    static func - (left: Wrapped, right: Optional<Wrapped>) -> Wrapped {
        if let value = right {
            return left - value
        }
        return left
    }

}


extension Optional where Wrapped == IntegerLiteralType {

    static func * (left: Optional<Wrapped>, right: Optional<Wrapped>) -> Wrapped {
        return left * right
    }

    static func * (left: Optional<Wrapped>, right: Wrapped) -> Wrapped {
        if let value = left {
            return value * right
        }
        return 0
    }

    static func * (left: Wrapped, right: Optional<Wrapped>) -> Wrapped {
        if let value = right {
            return left * value
        }
        return 0
    }

}


extension Optional where Wrapped == IntegerLiteralType {

    static func / (left: Optional<Wrapped>, right: Optional<Wrapped>) -> Optional<Wrapped> {
        return left / right
    }

    static func / (left: Optional<Wrapped>, right: Wrapped) -> Optional<Wrapped> {
        if 0 == right {
            return nil
        }
        if let value = left {
            return Optional(value / right)
        }
        return nil
    }

    static func / (left: Wrapped, right: Optional<Wrapped>) -> Optional<Wrapped> {
        if let value = right {
            if 0 == value {
                return nil
            }
            return Optional(left / value)
        }
        return nil
    }

}


extension Optional where Wrapped == IntegerLiteralType {

    static func % (left: Optional<Wrapped>, right: Optional<Wrapped>) -> Optional<Wrapped> {
        return left % right
    }

    static func % (left: Optional<Wrapped>, right: Wrapped) -> Optional<Wrapped> {
        if 0 == right {
            return nil
        }
        if let value = left {
            return Optional(value % right)
        }
        return nil
    }

    static func % (left: Wrapped, right: Optional<Wrapped>) -> Optional<Wrapped> {
        if let value = right {
            if 0 == value {
                return nil
            }
            return Optional(left % value)
        }
        return nil
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


