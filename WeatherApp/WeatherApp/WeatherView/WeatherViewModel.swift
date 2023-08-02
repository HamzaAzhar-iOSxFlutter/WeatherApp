//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Hamza Azhar on 01/08/2023.
//

import Foundation

// MARK: - WeatherModel
struct WeatherModel: Codable {
    let current: Current
}

// MARK: - Current
struct Current: Codable {
    let tempC, tempF: Double
    
    enum CodingKeys: String, CodingKey {
        case tempC = "temp_c"
        case tempF = "temp_f"
    }
}

protocol WeatherRefreshDelegate: AnyObject {
    func reloadWeather()
}

class WeatherViewModel {
    
    let baseURL = "https://api.weatherapi.com/v1/current.json?q="
    let apiKey = "ba125a4741684032b5b31544230208"
    var delegate: WeatherRefreshDelegate?
    
    init(binding : WeatherRefreshDelegate) {
        self.delegate = binding
    }
    
    func fetchWeatherDetails(locationName: String) {
        
        guard let url = URL(string: baseURL + locationName) else { return }
        
        let params = [
            "key": apiKey,
        ]
        
        var request = URLRequest(url: url)
        print(URLRequest(url: url))
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       // request.setValue(apiKey, forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else { return }
            
            print("The data is ", data)
            do {
                if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print("Response JSON: \(jsonResponse)")
                }
            }
        }
        task.resume()
    }
}
