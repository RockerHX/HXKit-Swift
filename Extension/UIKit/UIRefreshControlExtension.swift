//
//  UIRefreshControlExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/6/24.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


import UIKit


extension UIRefreshControl {

    func beginAnimateRefreshing() {
        guard let tableView = superview as? UITableView else { return }
        beginRefreshing()
        tableView.contentOffset = CGPoint(x: 0, y: tableView.contentOffset.y - frame.size.height)
        sendActions(for: .valueChanged)
    }

}

