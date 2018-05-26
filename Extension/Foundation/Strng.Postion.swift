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
        var postionIndex = String.Index(encodedOffset: postion)
        let left = self[startIndex..<postionIndex]
        postionIndex = String.Index(encodedOffset: (postion + 1))
        let right = self[postionIndex...]
        return [String(left), String(right)]
    }

    public func intercept(of subString: String, backwards: Bool = false) -> String {
        guard let interrupt = truncation(of: subString, backwards: backwards).first else { return "" }
        return interrupt
    }

}

