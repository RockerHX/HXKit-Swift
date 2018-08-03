//
//  HXRegionModel.swift
//  FishHead
//
//  Created by RockerHX on 2018/8/3.
//  Copyright © 2018年 RockerHX. All rights reserved.
//


struct HXRegion {}


extension HXRegion {

    struct HXRegionModel: Codable {
        var code: String
        var name: String
        var children: [HXRegionModel]? = nil
    }

}


extension HXRegion {

    struct Collection: Codable {
        var list: [HXRegionModel]
    }

}

