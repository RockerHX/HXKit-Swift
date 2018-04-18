//
//  String.Validate.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/3/2.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import Foundation


extension String {

    public enum Validate {}

}

extension String.Validate {

    public enum Tip {
        case pattern(tip: String)
        case account
        case passWord
        case captch
        case chineseName
        case id
        case email
        case mobile
        case telphone
        case phoneCode
        case money
        case bankID
        case unknown
    }

}

extension String.Validate.Tip: CustomStringConvertible {

    public var description: String {
        get {
            switch self {
            case .pattern(let tip):
                return "请输入正确\(tip)！"
            case .account:
                return "请输入正确账号！"
            case .passWord:
                return "密码至少六位，必须数字加字母组合！"
            case .captch:
                return "验证码至少四位！"
            case .chineseName:
                return "请输入正确的中文名！"
            case .id:
                return "请输入正确的身份证号码！"
            case .email:
                return "请输入正确的邮箱！"
            case .mobile:
                return "请输入正确手机号码！"
            case .telphone:
                return "请输入正确座机号码！"
            case .phoneCode:
                return "请输入正确电话号码！"
            case .money:
                return "请输入正确金额！"
            case .bankID:
                return "请输入正确银行卡号！"
            case .unknown:
                return "未知错误！"
            }
        }
    }

}


extension String.Validate {

    public enum Result {
        case empty
        case pass
        case failure(tip: String.Validate.Tip)
    }

}


extension String.Validate.Result {

    public static func | (lhs: String.Validate.Result, rhs: String.Validate.Result) -> String.Validate.Result {
        switch lhs {
        case .pass:
            return .pass
        default:
            switch rhs {
            case .pass:
                return .pass
            default:
                return .failure(tip: .unknown)
            }
        }
    }

    public static func & (lhs: String.Validate.Result, rhs: String.Validate.Result) -> String.Validate.Result {
        switch lhs {
        case .pass:
            switch rhs {
            case .pass:
                return .pass
            default:
                return .failure(tip: .unknown)
            }
        default:
            return .failure(tip: .unknown)
        }
    }

}


// MARK: - Pattern Validate -
extension String {

    public func validate(with pattern: String, tip: Validate.Tip) -> Validate.Result {
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        let result = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, count))
        return ((nil == result) ? .failure(tip: tip) : .pass)
    }

}


// MARK: - Pass Word Validate -
extension String {

    public func isAccount() -> Validate.Result {
        let pattern = "([a-zA-Z0-9]).{3,20}"
        return validate(with: pattern, tip: .account)
    }

    public func isPassWord() -> Validate.Result {
        let pattern = "(?!^\\d+$)(?!^[a-zA-Z]+$).{5,20}"
        return validate(with: pattern, tip: .passWord)
    }

    public func isCaptch() -> Validate.Result {
        let pattern = "([a-zA-Z0-9]).{3,6}"
        return validate(with: pattern, tip: .captch)
    }
}


// MARK: - Name Validate -
extension String {

    public func isChineseName() -> Validate.Result {
        let pattern = "^([\\u4e00-\\u9fcb\\·]{1,10})$"
        return validate(with: pattern, tip: .chineseName)
    }
}


// MARK: - ID Card Number Validate -
extension String {

    public func isIDCard() -> Validate.Result {
        let pattern = "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$)"
        return validate(with: pattern, tip: .id)
    }
}


// MARK: - Email Validate -
extension String {

    public func isEmail() -> Validate.Result {
        let pattern = "^(([\\w\\-\\.]+)@([\\w\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})$"
        return validate(with: pattern, tip: .email)
    }
}


// MARK: - Phone Number -
extension String {

    public func isMobile() -> Validate.Result {
        let pattern = "^(((1)\\d{10}))$"
        return validate(with: pattern, tip: .mobile)
    }

    public func isTelephone() -> Validate.Result {
        let pattern = "^(0\\d{2,3}[-| ]?)?(\\d{6,8})([-| ]?\\d{3,5})?$"
        return validate(with: pattern, tip: .telphone)
    }

    public func isPhoneNumber() -> Validate.Result {
        switch isMobile() | isTelephone() {
        case .pass:
            return .pass
        default:
            return .failure(tip: .phoneCode)
        }
    }

}


// MARK: - Money Validate -
extension String {

    public func isMoney() -> Validate.Result {
        let pattern = "^(0|[1-9][0-9]*)$"
        return validate(with: pattern, tip: .money)
    }

}


// MARK: - Card Validate -
extension String {

    public func isBankCardID() -> Validate.Result {
        let pattern = "^(\\d{19})$"
        return validate(with: pattern, tip: .bankID)
    }

}
