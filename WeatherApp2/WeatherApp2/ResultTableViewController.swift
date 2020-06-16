//
//  ResultTableViewController.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import UIKit

class ResultTableViewController: UITableViewController {
    
    @IBOutlet weak var buttonFind: UIButton!
    @IBOutlet weak var buttonCancel: UIButton!
    @IBOutlet weak var textcityyFinder: UITextField!
    
    var locations = [CityModel]()
    
    var selectedCity: CityModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonClicked(_ sender: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func findCities(_ sender: UIButton) {
        self.locations.removeAll()
        
        let city = textcityyFinder.text!
        
        WeatherAPI().getCityForWeather(cityName: city, callback: saveDataAndUpdateView)
    }
    
    func saveDataAndUpdateView(cities: [CityModel]) {
        DispatchQueue.main.async {
            for i in 0..<cities.count {
                print("city callback - \(cities[i].nameOfCity)")
                self.locations.append(cities[i])
            }
            
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].nameOfCity
        cell.tag = Int(locations[indexPath.row].idOfCity)!
        
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
        destination.locations.append(self.selectedCity!)
        
        destination.tableView.reloadData()
        destination.getWeather(cityId: self.selectedCity!.idOfCity, cityName: self.selectedCity!.nameOfCity)
    }
    
}
