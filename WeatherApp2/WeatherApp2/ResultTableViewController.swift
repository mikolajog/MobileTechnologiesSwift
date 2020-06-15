//
//  ResultTableViewController.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    
    var cities = [CityModel]()
    var selectedCity: CityModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func findCities(_ sender: UIButton) {
        self.cities.removeAll()
        let city = cityTextField.text!
        WeatherAPI().findCity(cityName: city, callback: saveDataAndUpdateView)
    }
    
    func saveDataAndUpdateView(cities: [CityModel]) {
        DispatchQueue.main.async {
            for i in 0..<cities.count {
                print("city callback - \(cities[i].name)")
                self.cities.append(cities[i])
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].name
        cell.tag = Int(cities[indexPath.row].id)!
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRow(at: indexPath!)!
        self.selectedCity = CityModel(name: (cell.textLabel?.text!)!, id: String(cell.tag))
        performSegue(withIdentifier: "unwindSegueToMasterView", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! MasterViewController
        destination.cities.append(self.selectedCity!)
        destination.tableView.reloadData()
        destination.readWeather(cityId: self.selectedCity!.id, cityName: self.selectedCity!.name)
    }
    
}
