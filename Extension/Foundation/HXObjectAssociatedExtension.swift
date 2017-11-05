//
//  HXObjectAssociatedExtension.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/2/26.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import Foundation


extension NSObject {
    //----------------------------------------------------------------------------
    // MARK: - Associated Objects
    //----------------------------------------------------------------------------
    public func associatedObject(forKey key: UnsafeRawPointer!) -> Any! {
        return objc_getAssociatedObject(self, key)
    }
    
    public func associate(retainObject object: Any!, forKey key: UnsafeRawPointer!) {
        objc_setAssociatedObject(self, key, object, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
}
