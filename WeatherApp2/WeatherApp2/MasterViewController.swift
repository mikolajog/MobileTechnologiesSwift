//
//  MasterViewController.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import UIKit

protocol CitySelectionDelegate: class {
    func selectedCityForecast(_ forecast: CityForecast)
}

class MasterViewController: UITableViewController {
    
    var cities = [
        City(name: "New York", id: "2459115"),
        City(name: "Chicago", id: "2379574"),
        City(name: "Miami", id: "2450022")
    ]
    
    var cityIds = [Int: String]()
    var forecasts = [String: CityForecast]()
    
    weak var delegate: CitySelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readWeatherForAllCities()
    }
    
    func readWeatherForAllCities() {
        for city in cities {
            readWeather(cityId: city.id, cityName: city.name)
        }
    }
    
    
    func readWeather(cityId: String, cityName: String) {
        ApiHandler().getLocationForecast(locationId: cityId, callback: saveDataAndUpdateView)
    }
    
    func saveDataAndUpdateView(forecast: CityForecast) {
        DispatchQueue.main.async {
            self.forecasts[forecast.cityId] = forecast
            self.updateView(locationForecast: forecast)
        }
    }
    
    func updateView(locationForecast: CityForecast) {
        let tableCell = self.tableView?.visibleCells
        
        if let cells = tableCell {
            for cell in cells {
                let cityId = cityIds[cell.tag]
                if cityId == locationForecast.cityId {
                    let forecast = locationForecast.getDailyForecast()
                    cell.imageView?.image = UIImage(named: forecast.abbrev)
                    cell.detailTextLabel?.text = "\(forecast.tempMain)°C"
                    
                    if cityId == cities[0].id {
                        delegate?.selectedCityForecast(locationForecast)
                    }
                    
                    break
                }
            }
        }
    }
    
    @IBAction func unwindToMV(segue:UIStoryboardSegue) { }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row].name
        cell.tag = indexPath.row
        cityIds[cell.tag] = cities[indexPath.row].id
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = cities[indexPath.row]
        delegate?.selectedCityForecast(forecasts[selectedCity.id]!)
        
        if let detailViewController = delegate as? ViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    
}


