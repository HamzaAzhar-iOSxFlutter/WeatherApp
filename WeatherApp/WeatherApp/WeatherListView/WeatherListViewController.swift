//
//  WeatherListViewController.swift
//  WeatherApp
//
//  Created by Hamza Azhar on 01/08/2023.
//

import UIKit

class WeatherListViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(UINib(nibName: "WeatherListTableViewCell", bundle: nil), forCellReuseIdentifier: "WeatherListTableViewCell")
    }
}

extension WeatherListViewController: UITableViewDelegate {
    
}

extension WeatherListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherListTableViewCell", for: indexPath)
        return cell
    }
    
    
}
