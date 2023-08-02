//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Hamza Azhar on 31/07/2023.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController {
    
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!

    @IBOutlet weak var labelTemperature: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var buttonSearch: UIButton!
    @IBOutlet weak var buttonLocation: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
