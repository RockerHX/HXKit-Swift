//
//  Identifierable.swift
//  HXKit-Swift
//
//  Created by Andy Shaw on 2022/6/2.
//

import Foundation

protocol Identifierable {
    static func identifier() -> String
}

extension Identifierable where Self: AnyObject {

    static func identifier() -> String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

}
