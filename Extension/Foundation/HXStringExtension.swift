//
//  HXStringExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/3/2.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import Foundation


enum HXStringValidate: String {
    case Account     = "请输入正确账号！"
    case PassWord    = "密码至少六位，必须数字加字母组合！"
    case Captch      = "验证码至少四位！"
    case ChineseName = "请输入正确的中文名！"
    case IDNumber    = "请输入正确的身份证号码！"
    case Email       = "请输入正确的邮箱！"
    case Mobile      = "请输入正确手机号码！"
    case TelPhone    = "请输入正确座机号码！"
    case Phone       = "请输入正确电话号码！"
    case Money       = "请输入正确金额！"
    case BankCardID  = "请输入正确银行卡号！"

    var tips: String {
        get {
            return self.rawValue
        }
    }
}


// MARK: - Pass Word Validate
extension String {

    fileprivate func validate(withPattern pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options(rawValue: 0))
        let result = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, count))
        return ((result == nil) ? false : true)
    }
}


// MARK: - Pass Word Validate
extension String {

    public func isAccount() -> (pass: Bool, message: String) {
        let pattern = "([a-zA-Z0-9]).{3,20}"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.Account.tips))
    }

    public func isPassWord() -> (pass: Bool, message: String) {
        let pattern = "(?!^\\d+$)(?!^[a-zA-Z]+$).{5,20}"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.PassWord.tips))
    }

    public func isCaptch() -> (pass: Bool, message: String) {
        let pattern = "([a-zA-Z0-9]).{3,6}"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.Captch.tips))
    }
}


// MARK: - Name Validate
extension String {

    public func isChineseName() -> (pass: Bool, message: String) {
        let pattern = "^([\\u4e00-\\u9fcb\\·]{1,10})$"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.ChineseName.tips))
    }
}


// MARK: - ID Card Number Validate
extension String {

    public func isIDCard() -> (pass: Bool, message: String) {
        let pattern = "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$)"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.IDNumber.tips))
    }
}


// MARK: - Email Validate
extension String {

    public func isEmail() -> (pass: Bool, message: String) {
        let pattern = "^(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})$"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.Email.tips))
    }
}


// MARK: - Phone Number
extension String {

    public func isMobileNumber() -> (pass: Bool, message: String) {
        let pattern = "^(((1)\\d{10}))$"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.Mobile.tips))
    }

    public func isTelephoneNumber() -> (pass: Bool, message: String) {
        let pattern = "^(0\\d{2,3}[-| ]?)?(\\d{6,8})([-| ]?\\d{3,5})?$"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.TelPhone.tips))
    }

    public func isPhoneNumber() -> (pass: Bool, message: String) {
        let pass = isMobileNumber().pass || isTelephoneNumber().pass
        return (pass, (pass ? "" : HXStringValidate.Phone.tips))
    }
}


// MARK: - Money Validate
extension String {

    public func isMoney() -> (pass: Bool, message: String) {
        let pattern = "^(0|[1-9][0-9]*)$"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.Money.tips))
    }
}


// MARK: - Card Validate
extension String {

    public func isBankCardID() -> (pass: Bool, message: String) {
        let pattern = "^(\\d{19})$"
        let pass = validate(withPattern: pattern)
        return (pass, (pass ? "" : HXStringValidate.BankCardID.tips))
    }
}
