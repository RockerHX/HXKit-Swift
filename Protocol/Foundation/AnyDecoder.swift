//
//  AnyDecoder.swift
//  FishHead
//
//  Created by RockerHX on 2018/9/7.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


import Foundation


protocol AnyDecoder {
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
}


extension JSONDecoder: AnyDecoder {}
extension PropertyListDecoder: AnyDecoder {}


extension Data {

    func decoded<T: Decodable>(using decoder: AnyDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }

}

