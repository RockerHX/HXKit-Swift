//
//  Strng.Postion.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/5/22.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import Foundation


extension String {

    public func position(of subString: String, backwards: Bool = false) -> Int {
        var pos = -1
        if let range = range(of: subString, options: (backwards ? .backwards : .literal)) {
            if !range.isEmpty {
                pos = self.distance(from: startIndex, to: range.lowerBound)
            }
        }
        return pos
    }

    public func truncation(of subString: String, backwards: Bool = false) -> [String] {
        let postion = position(of: subString, backwards: backwards)
        var postionIndex = String.Index(utf16Offset: postion, in: subString)
        let left = self[startIndex..<postionIndex]
        postionIndex = String.Index(utf16Offset: (postion + 1), in: subString)
        let right = self[postionIndex...]
        return [String(left), String(right)]
    }

    public func intercept(of subString: String, backwards: Bool = false) -> String {
        guard let interrupt = truncation(of: subString, backwards: backwards).first else { return "" }
        return interrupt
    }

}


extension String {

    func delete(prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }

    func delete(suffix: String) -> String {
        guard self.contains(suffix) else { return self }
        return String(self.dropLast(suffix.count))
    }

    func delete(prefix: String, suffix: String) -> String {
        let tmp = self.delete(prefix: prefix)
        return tmp.delete(suffix: suffix)
    }

}

