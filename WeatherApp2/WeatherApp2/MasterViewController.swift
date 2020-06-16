//
//  MasterViewController.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import UIKit

protocol CitySelectionDelegate: class {
    func selectedCityForecast(_ forecast: CityWeather)
}

class MasterViewController: UITableViewController {
    
    var locations = [
        CityModel(name: "Osaka", id: "15015370"),
        CityModel(name: "Houston", id: "2424766"),
        CityModel(name: "Moscow", id: "2122265")
    ]
    
    var idsOfCity = [Int: String]()
    
    var weather = [String: CityWeather]()
    
    weak var delegate: CitySelectionDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllCitiesWeather()
    }
    
    func getAllCitiesWeather() {
        for city in locations {
            getWeather(cityId: city.idOfCity, cityName: city.nameOfCity)
        }
    }
    
    
    func getWeather(cityId: String, cityName: String) {
        WeatherAPI().getWeatherForLocation(locationId: cityId, callback: datasaveandViewUpdate)
    }
    
    func datasaveandViewUpdate(forecast: CityWeather) {
        DispatchQueue.main.async {
            self.weather[forecast.idOfCity] = forecast
            self.updateView(locationForecast: forecast)
        }
    }
    
    func updateView(locationForecast: CityWeather) {
        let tableCell = self.tableView?.visibleCells
        
        if let cells = tableCell {
            for cell in cells {
                let cityId = idsOfCity[cell.tag]
                if cityId == locationForecast.idOfCity {
                    let forecast = locationForecast.getDay()
                    cell.imageView?.image = UIImage(named: forecast.img)
                    cell.detailTextLabel?.text = "\(forecast.tempMain)°C"
                    
                    if cityId == locations[0].idOfCity {
                        delegate?.selectedCityForecast(locationForecast)
                    }
                    
                    break
                }
            }
        }
    }
    
    @IBAction func unwindToMV(segue:UIStoryboardSegue) { }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locations.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = locations[indexPath.row].nameOfCity
        cell.tag = indexPath.row
        idsOfCity[cell.tag] = locations[indexPath.row].idOfCity
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = locations[indexPath.row]
        delegate?.selectedCityForecast(weather[selectedCity.idOfCity]!)
        
        if let detailViewController = delegate as? ViewController {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    
}


