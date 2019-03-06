//
//  HXCellExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/3/9.
//  Copyright © 2018年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


extension UITableViewCell {

    static func identifier() -> String {
        return String(describing: self)
    }

}


extension UICollectionViewCell {

    static func identifier() -> String {
        return String(describing: self)
    }

}

