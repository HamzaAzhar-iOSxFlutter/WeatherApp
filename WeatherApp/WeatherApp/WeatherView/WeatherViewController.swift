//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Hamza Azhar on 31/07/2023.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var buttonCities: UIButton!
    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonLocation: UIButton!
    
    var weatherTracker: WeatherModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.makeInitialWeatherRequest()
        self.buttonCities.layer.cornerRadius = self.buttonCities.frame.height / 2
        self.labelTemperature.text = ""
    }
    
    fileprivate func makeInitialWeatherRequest() {
        LocationManager.shared.getLocation { [weak self] location in
            DispatchQueue.main.async {
                guard let self = self else { return }
                print("latitude: " ,location.coordinate.latitude)
                print("longitude: " ,location.coordinate.longitude)
                
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                
                let viewModel: WeatherViewModel = WeatherViewModel(binding: self)
                viewModel.fetchWeatherDetailsWith(latitude: latitude, longitude: longitude) { weatherModel, status in
                    switch status {
                    case true:
                        self.weatherTracker = weatherModel
                        DispatchQueue.main.async { [weak self] in
                            self?.labelTemperature.text = "\(weatherModel?.current.tempC ?? 0.0)"
                        }
                    case false:
                        break
                    }
                }
            }
        }
    }
    
    @IBAction func didSelectSegmentControl(_ sender: UISegmentedControl) {
        guard let weather = weatherTracker else { return }
        switch segmentControl.selectedSegmentIndex {
        case 0:
            self.labelTemperature.text = "\(weather.current.tempC ?? 0.0)"
        case 1:
            self.labelTemperature.text = "\(weather.current.tempF ?? 0.0)"
        default:
            break
        }
    }
    
    
    @IBAction func didTapLocation(_ sender: Any) {
        self.makeInitialWeatherRequest()
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
    }
    
    @IBAction func didTapCities(_ sender: Any) {
        //        let vc = WeatherListViewController()
        //        self.navigationController?.pushViewController(vc
        //                                                      , animated: true)
    }
}

extension WeatherViewController: WeatherRefreshDelegate {
    func reloadWeather() {
        print("Hello")
    }
}
