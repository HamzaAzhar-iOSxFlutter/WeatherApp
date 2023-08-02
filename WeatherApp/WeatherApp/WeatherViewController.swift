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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        LocationManager.shared.getLocation { [weak self] location in
            DispatchQueue.main.async {
                //guard let self = self else { return }
                print("latitude: " ,location.coordinate.latitude)
                print("longitude: " ,location.coordinate.longitude)
            }
        }
      
    }
    
    
    @IBAction func didTapLocation(_ sender: Any) {
    }
    
    @IBAction func didTapSearch(_ sender: Any) {
    }
    
    @IBAction func didTapCities(_ sender: Any) {
    }
}
