//
//  WeatherIcon.swift
//  WeatherList
//
//  Created by chloe on 2023/06/22.
//

import UIKit

/**[Weather Icons](https://erikflowers.github.io/weather-icons/)*/
@frozen enum WeatherIcon {
    case thunderstorm
    case shower
    case rain
    case snow
    case mist
    
    case clear
    case few        // 11~25%
    case scattered  // ~50%
    case broken     // ~84%
    case overcast   // ~100%
    
    case none
    
    var image: UIImage {
        switch self {
        case .thunderstorm:
            return #imageLiteral(resourceName: "wi-night-lightning")
        case .shower:
            return #imageLiteral(resourceName: "wi-rain")
        case .rain:
            return #imageLiteral(resourceName: "wi-night-rain")
        case .snow:
            return #imageLiteral(resourceName: "wi-snow")
        case .mist:
            return #imageLiteral(resourceName: "wi-fog")
        case .clear:
            return #imageLiteral(resourceName: "wi-day-sunny")
        case .few:
            return #imageLiteral(resourceName: "wi-day-cloudy")
        case .scattered:
            return #imageLiteral(resourceName: "wi-cloud")
        case .broken:
            return #imageLiteral(resourceName: "wi-cloudy")
        case .overcast:
            return #imageLiteral(resourceName: "wi-cloudy")
        case .none:
            return #imageLiteral(resourceName: "wi-na")
        }
    }
    
    
    init(rawValue: Int) {
        switch rawValue {
        case 200...232:
            self = .thunderstorm
        case 300...321, 520...531:
            self = .shower
        case 500...504:
            self = .rain
        case 511, 600...622:
            self = .snow
        case 701...781:
            self = .mist
        case 800:
            self = .clear
        case 801:
            self = .few
        case 802:
            self = .scattered
        case 803:
            self = .broken
        case 804:
            self = .overcast
        default:
            self = .none
        }
    }
}
