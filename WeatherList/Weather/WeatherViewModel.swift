//
//  WeatherViewModel.swift
//  WeatherList
//
//  Created by chloe on 2023/06/21.
//

import RxSwift
import RxCocoa

final class WeatherViewModel {
    private let apiManager = APIManager.shared
    
    private(set) var items: BehaviorRelay<[Location: [Weather]]> = .init(value: [:])
    
    func requestDailyWeather() {
        let collection = Location.allCases.map { location in
            apiManager.dailyWeather(with: location).asObservable()
        }
        
        _ = Observable.combineLatest(collection)
            .subscribe { [weak self] array in
                guard let self = self else { return }
                
                var dic = [Location: [Weather]]()
                
                _ = array.map { data in
                    if let location = data.location {
                        dic[location] = Array(data.daily.prefix(6))
                    }
                }
                
                items.accept(dic)
                
            } onError: { error in
            print(error)
        }
    }
}
