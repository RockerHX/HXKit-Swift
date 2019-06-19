//
//  String.Translate.swift
//  VoiceMai
//
//  Created by RockerHX on 2019/6/19.
//  Copyright © 2019 RockerHX. All rights reserved.
//


import Foundation


extension String {

    //将原始的url编码为合法的url
    func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }

    //将编码后的url转换回原始的url
    func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
}

