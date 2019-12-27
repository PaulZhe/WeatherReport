//
//  RequestManager.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/25.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

typealias CityWeatherCompletionHandler = (CityMessageModel) -> ()
typealias LocationsCompletionHandler = (LoactionMessageModel) -> ()
typealias FailureHandler = (Error) -> ()
enum RequestError : Error {
    case urlHasWrong
    case dataIsNil
    case jsonDecodeFailed
}

class RequestManager: NSObject {
//    static let manager = RequestManager()
    
    static func requestCityWeather(with cityName: String, success : @escaping CityWeatherCompletionHandler, failure : @escaping FailureHandler) {
        guard let url = getCityWeatherURLFromComponents(cityName) else {
            failure(RequestError.urlHasWrong)
            return
        }
        let request = URLRequest.init(url: url)

        URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error : Error?) in
            
            guard let data = data else {
                failure(RequestError.dataIsNil)
                return
            }
            
            let decoder = JSONDecoder()
            guard let cityWeatherModel = try? decoder.decode(CityMessageModel.self, from: data) else {
                failure(RequestError.jsonDecodeFailed)
                return
            }
            success(cityWeatherModel)
        }.resume()
        
    }
    
    static func requestLocations(with inputString: String, success : @escaping LocationsCompletionHandler, failure : @escaping FailureHandler) {
        guard let url = getLocationsURLFromComponents(inputString) else {
            failure(RequestError.urlHasWrong)
            return
        }
        let request = URLRequest.init(url: url)

        URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error : Error?) in
            
            guard let data = data else {
                failure(RequestError.dataIsNil)
                return
            }
            
            let decoder = JSONDecoder()
            guard let locationMessageModel = try? decoder.decode(LoactionMessageModel.self, from: data) else {
                failure(RequestError.jsonDecodeFailed)
                return
            }
            success(locationMessageModel)
        }.resume()
        
    }
    
    static private func getCityWeatherURLFromComponents(_ cityName: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "free-api.heweather.com"
        components.path = "/s6/weather/now"
        let queryItemLocation = URLQueryItem(name: "location", value: cityName)
        let queryItemKey = URLQueryItem(name: "key", value: "c563861f72c649f2a698a472080eaa8c")
        components.queryItems = [queryItemLocation, queryItemKey]
        return components.url
    }
    
    static private func getLocationsURLFromComponents(_ inputString: String) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "search.heweather.com"
        components.path = "/find"
        let queryItemLocation = URLQueryItem(name: "location", value: inputString)
        let queryItemKey = URLQueryItem(name: "key", value: "c563861f72c649f2a698a472080eaa8c")
        components.queryItems = [queryItemLocation, queryItemKey]
        return components.url
    }
}
