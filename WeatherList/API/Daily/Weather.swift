//
//  Weather.swift
//  WeatherList
//
//  Created by chloe on 2023/06/21.
//

import Foundation
import UIKit

struct DailyWeather: Codable {
    let daily: [Weather]
    private(set) var location: Location?
    
    private enum CodingKeys: String, CodingKey {
        case daily
        case location = "timezone"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        daily = try container.decode([Weather].self, forKey: .daily)
        let timezone = try container.decode(String.self, forKey: .location)
        
        _ = Location.allCases.map {
            if timezone.contains($0.rawValue) {
                location = $0
            }
        }
    }
}

struct Weather: Codable {
    let date: Date
    let weather: WeatherImage?
    let temperature: Temperature
    
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case weather = "weather"
        case temperature = "temp"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        let epochTime = try container.decode(Int.self, forKey: .date)
        date = Date(timeIntervalSince1970: TimeInterval(epochTime))
        
        let weatherArray = try container.decode([WeatherImage].self, forKey: .weather)
        weather = weatherArray.first
        
        temperature = try container.decode(Temperature.self, forKey: .temperature)
    }
}

struct Temperature: Codable {
    let min: Int, max: Int
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        min = Int(round( try container.decode(Double.self, forKey: .min)))
        max = Int(round( try container.decode(Double.self, forKey: .max)))
    }
}

struct WeatherImage: Codable {
    let id: Int, main: String, icon: String
    let desc: String
    let image: UIImage
    
    private enum CodingKeys: String, CodingKey {
        case id, main, icon
        case desc = "description"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(Int.self, forKey: .id)
        main = try container.decode(String.self, forKey: .main)
        icon = try container.decode(String.self, forKey: .icon)
        desc = try container.decode(String.self, forKey: .desc)
        
        image = WeatherIcon(rawValue: id).image
    }
}
