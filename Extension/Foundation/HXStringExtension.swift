//
//  HXStringExtension.swift
//  XRDLoanServices
//
//  Created by XRD.Andy on 2017/3/2.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


import Foundation


enum HXStringValidate: String {
    case Account     = "请输入正确账号！"
    case PassWord    = "密码至少六位，必须数字加字母组合！"
    case ChineseName = "请输入正确的中文名！"
    case IDNumber    = "请输入正确的身份证号码！"
    case Email       = "请输入正确的邮箱！"
    case Mobile      = "请输入正确手机号码！"
    case TelPhone    = "请输入正确座机号码！"
    case Phone       = "请输入正确电话号码！"
    
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
        let result = regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count))
        return ((result == nil) ? false : true)
    }
}


// MARK: - Pass Word Validate
extension String {
    
    public func isAccount() -> (success: Bool, message: String) {
        let pattern = "([a-zA-Z0-9]).{3,20}"
        let success = validate(withPattern: pattern)
        return (success, (success ? "" : HXStringValidate.Account.tips))
    }
    
    public func isPassWord() -> (success: Bool, message: String) {
        let pattern = "(?!^\\d+$)(?!^[a-zA-Z]+$).{5,20}"
        let success = validate(withPattern: pattern)
        return (success, (success ? "" : HXStringValidate.PassWord.tips))
    }
}


// MARK: - ID Card Number Validate
extension String {
    
    public func isChineseName() -> (success: Bool, message: String) {
        let pattern = "^([\\u4e00-\\u9fcb\\·]{1,10})$"
        let success = validate(withPattern: pattern)
        return (success, (success ? "" : HXStringValidate.ChineseName.tips))
    }
}


// MARK: - ID Card Number Validate
extension String {
    
    public func isIDNumber() -> (success: Bool, message: String) {
        let pattern = "(^[1-9]\\d{5}(18|19|([23]\\d))\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{3}[0-9Xx]$)|(^[1-9]\\d{5}\\d{2}((0[1-9])|(10|11|12))(([0-2][1-9])|10|20|30|31)\\d{2}$)"
        let success = validate(withPattern: pattern)
        return (success, (success ? "" : HXStringValidate.IDNumber.tips))
    }
}


// MARK: - Email Validate
extension String {
    
    public func isEmail() -> (success: Bool, message: String) {
        let pattern = "^(([a-zA-Z0-9_\\-\\.]+)@([a-zA-Z0-9_\\-\\.]+)\\.([a-zA-Z]{2,5}){1,25})$"
        let success = validate(withPattern: pattern)
        return (success, (success ? "" : HXStringValidate.Email.tips))
    }
}


// MARK: - Phone Number
extension String {
    
    public func isMobileNumber() -> (success: Bool, message: String) {
        let pattern = "^(((1)\\d{10}))$"
        let success = validate(withPattern: pattern)
        return (success, (success ? "" : HXStringValidate.Mobile.tips))
    }
    
    public func isTelephoneNumber() -> (success: Bool, message: String) {
        let pattern = "^(0\\d{2,3}[-| ]?)?(\\d{6,8})([-| ]?\\d{3,5})?$"
        let success = validate(withPattern: pattern)
        return (success, (success ? "" : HXStringValidate.TelPhone.tips))
    }
    
    public func isPhoneNumber() -> (success: Bool, message: String) {
        let success = isMobileNumber().success || isTelephoneNumber().success
        return (success, (success ? "" : HXStringValidate.Phone.tips))
    }
}
