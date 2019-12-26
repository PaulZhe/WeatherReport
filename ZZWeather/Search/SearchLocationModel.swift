//
//  SearchLocationModel.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/26.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

struct ConcreteLocationBasicMessage : Decodable {
    let cid : String
    let location : String
    let parent_city : String
    let admin_area : String
    let cnty : String
    let lat : String
    let lon : String
    let tz : String
    let type : String
}

struct ConcreteLocationMessage : Decodable {
    let basic : [ConcreteCityBasicMessage]
    let status : String
}

struct LoactionMessageModel : Decodable {
    let HeWeather6 : [ConcreteLocationMessage]
}
