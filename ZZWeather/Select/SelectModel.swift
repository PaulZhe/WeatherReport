//
//  SelectModel.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/25.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

struct ConcreteCityBasicMessage : Decodable {
    let cid : String
    let location : String
    let parent_city : String
    let admin_area : String
    let cnty : String
    let lat : String
    let lon : String
    let tz : String
}

struct ConcreteCityUpdateTime : Decodable {
    let loc : String
    let utc : String
}

struct ConcreteCityNowMessage : Decodable {
    let cloud : String
    let cond_code : String
    let cond_txt : String
    let fl : String
    let hum : String
    let pcpn : String
    let pres : String
    let tmp : String
    let vis : String
    let wind_deg : String
    let wind_dir : String
    let wind_sc : String
    let wind_spd : String
}

struct ConcreteCityMessage : Decodable {
    let basic : ConcreteCityBasicMessage
    let update : ConcreteCityUpdateTime
    let status : String
    let now : ConcreteCityNowMessage
}

struct CityMessageModel : Decodable {
    let HeWeather6 : [ConcreteCityMessage]
}
