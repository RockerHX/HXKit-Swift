//
//  AnyEncoder.swift
//  FishHead
//
//  Created by RockerHX on 2018/9/11.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


import Foundation


protocol AnyEncoder {
    func encode<T: Encodable>(_ value: T) throws -> Data
}


extension JSONEncoder: AnyEncoder {}
extension PropertyListEncoder: AnyEncoder {}


extension Encodable {

    func encoded(using encoder: AnyEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }

}

