//
//  Location.swift
//  WeatherList
//
//  Created by chloe on 2023/06/22.
//

import Foundation

/** 순서대로 오늘부터 6일간의 날씨 정보 노출*/
@frozen enum Location: String, CaseIterable, Codable {
    case seoul = "Seoul"
    case london = "London"
    case chicago = "Chicago"
    
    var latitude: Double {
        switch self {
        case .seoul:
            return 37.5666791
        case .london:
            return 51.5073219
        case .chicago:
            return 41.8755616
        }
    }
    
    var longitude: Double {
        switch self {
        case .seoul:
            return 126.9782914
        case .london:
            return -0.1276474
        case .chicago:
            return -87.6244212
        }
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE dd MMM"
        
        switch self {
        case .seoul:
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "KST")
        case .london:
            formatter.locale = Locale(identifier: "en_US_POSIX")
            formatter.timeZone = TimeZone(abbreviation: "GMT")
        case .chicago:
            formatter.locale = Locale(identifier: "en_US")
            formatter.timeZone = TimeZone(abbreviation: "CDT")
        }
        return formatter
    }
}
