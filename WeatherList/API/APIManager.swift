//
//  APIManager.swift
//  WeatherList
//
//  Created by chloe on 2023/06/21.
//

import Alamofire
import RxSwift

final class APIManager {
    
    static let shared = APIManager()
    
    private func request<D: Decodable>(api: API) -> Single<D> {
        return Single<D>.create { single -> Disposable in
            AF.request(api.target,
                       method: api.method,
                       parameters: api.paramaters,
                       encoding: URLEncoding.default,
                       headers: api.headers,
                       interceptor: nil,
                       requestModifier: nil).validate()
                .responseDecodable(of: D.self) { res in
                    switch res.result {
                    case .success(let value): single(.success(value))
                    case .failure(let error): single(.failure(error))
                    }
                }
            return Disposables.create()
        }
    }
    
    func dailyWeather(with location: Location) -> Single<DailyWeather> {
        return request(api: API.dailyWeather(location: location))
    }
}
