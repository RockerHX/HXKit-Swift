//
//  HXSegue.swift
//  News
//
//  Created by RockerHX on 2018/3/12.
//  Copyright © 2018年 RockerHX. All rights reserved.
//

import Foundation


protocol HXSegue: RawRepresentable {
    var identifier: String { get }
}

extension HXSegue {
    var identifier: String {
        get {
            return self.rawValue as! String
        }
    }
}

