//
//  RequestManager.swift
//  ZZWeather
//
//  Created by zhangzhe on 2019/12/25.
//  Copyright © 2019 zhangzhe. All rights reserved.
//

import UIKit

//typealias CompletionHandler = (CityMessageModel) -> ()
//typealias FailureHandler = () -> ()
//enum RequestError : Error {
//    case urlHasWrong
//    case dataIsNil
//}
//
//class RequestManager: NSObject {
//    static let manager = RequestManager()
//    
//    func requestCityWeather(with cityName: String, succeedClosure : @escaping CompletionHandler, failClosure : @escaping FailureHandler) throws {
//        guard let url = GetURLFromComponents(cityName) else {
//            throw RequestError.urlHasWrong
//        }
//        let request = URLRequest.init(url: url)
//
//        URLSession.shared.dataTask(with: request) { (data : Data?, response : URLResponse?, error : Error?) in
//            
//            guard let data = data else {
//                failClosure()
//                return
//            }
//            
//            let decoder = JSONDecoder()
//            guard let cityWeatherModel = try? decoder.decode(CityMessageModel.self, from: data) else {
//                fatalError("JSON Decode Failed")
//            }
//            succeedClosure(cityWeatherModel)
//        }.resume()
//        
//    }
//    
//    private func GetURLFromComponents(_ cityName: String) -> URL? {
//        var components = URLComponents()
//        components.scheme = "https"
//        components.host = "free-api.heweather.com/s6/weather/now"
//        let queryItemLocation = URLQueryItem(name: "location", value: cityName)
//        let queryItemKey = URLQueryItem(name: "key", value: "c563861f72c649f2a698a472080eaa8c")
//        components.queryItems = [queryItemLocation, queryItemKey]
//        return components.url
//    }
//}
