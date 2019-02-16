//
//  FastNotification.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/4/18.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


import Foundation


protocol FastNotification: RawRepresentable {

    var value: String { get }
    var notifacation: Notification { get }
    var name: Notification.Name { get }

}


extension FastNotification {

    var value: String {
        return rawValue as! String
    }

    var notifacation: Notification {
        return Notification(name: name)
    }

    var name: Notification.Name {
        return Notification.Name(value)
    }

}
