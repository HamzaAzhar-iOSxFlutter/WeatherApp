//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Taimoor Mujahid on 2023-08-02.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let tempC, tempF: Double?
    let condition: WeatherCondition?
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
        case condition = "condition"
    }
}

struct WeatherCondition: Codable {
    let text, icon: String?
    let code: Int?
    
    enum CodingKeys: String, CodingKey {
        case text
        case icon
        case code
    }
}


protocol WeatherRefreshDelegate: AnyObject {
    func reloadWeather()
}

class WeatherViewModel {
    
    let searchQuery = "search.json"
    let currentQuery = "current.json"
    let baseURL = "https://api.weatherapi.com/v1/"
    let apiKey = "ba125a4741684032b5b31544230208"
    var delegate: WeatherRefreshDelegate?
    
    init(binding : WeatherRefreshDelegate) {
        self.delegate = binding
    }
    
    func fetchWeatherDetailsWith(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?, Bool) -> ()) {
        
        guard var urlComponent = URLComponents(string: baseURL + currentQuery) else { return }
        
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)")
        ]
        guard let url = urlComponent.url?.absoluteURL else { return }
        let task = URLSession.shared.dataTask(with:  url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weatherModel, true)
                print(weatherModel)
            } catch {
                completion(nil, false)
            }
        }
        task.resume()
    }
    
    func fetchWeatherBasedOn(cityName: String, completion: @escaping (WeatherModel?, Bool) -> ()) {
        guard var urlComponent = URLComponents(string: baseURL + self.searchQuery) else { return }
        urlComponent.queryItems = [
            URLQueryItem(name: "key", value: self.apiKey),
            URLQueryItem(name: "q", value: "\(cityName)")
        ]
        guard let url = urlComponent.url?.absoluteURL else { return }
        let task = URLSession.shared.dataTask(with:  url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let weatherModel = try JSONDecoder().decode(WeatherModel.self, from: data)
                completion(weatherModel, true)
                print(weatherModel)
            } catch {
                completion(nil, false)
            }
        }
        task.resume()
    }
}
