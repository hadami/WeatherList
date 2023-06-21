//
//  Extension.swift
//  WeatherList
//
//  Created by chloe on 2023/06/21.
//

import Foundation

extension Collection where Indices.Iterator.Element == Index {
    subscript (safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension Date {
    func toString(with location: Location) -> String {
        return location.dateFormatter.string(from: self)
    }
}
