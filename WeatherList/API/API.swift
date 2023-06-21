//
//  API.swift
//  WeatherList
//
//  Created by chloe on 2023/06/21.
//

import Alamofire
import Foundation

@frozen enum API {
    
    /** [Open Weather API](https://openweathermap.org/api/one-call-3#how) */
    case dailyWeather(location: Location)
    
    var urlString: String {
        return self.baseURL+self.path
    }
    
    var target: URL! {
        guard let components = URLComponents(string: self.baseURL+self.path) else { return URL(string: "") }
        
        return components.url
    }
    
    var baseURL: String {
        switch self {
        case .dailyWeather:
            return "https://api.openweathermap.org/"
        }
    }
    
    var path: String {
        switch self {
        case .dailyWeather:
            return "data/3.0/onecall"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .dailyWeather:
            return HTTPMethod.get
        }
    }
    
    var headers: HTTPHeaders {
        let headers = HTTPHeaders()
        
        switch self {
        default: ()
        }
        return headers
    }
    
    public var paramaters: Parameters {
        switch self {
        case .dailyWeather(let location):
            let params: Parameters = [
                "lat": location.latitude,
                "lon": location.longitude,
                "appid": "4949f35204523c6c2037c0bef5b1a089",
                "units": "metric",
//                "lang": "kr",
                "exclude": "current,minutely,hourly,alerts"
            ]
            return params
        }
    }
}
