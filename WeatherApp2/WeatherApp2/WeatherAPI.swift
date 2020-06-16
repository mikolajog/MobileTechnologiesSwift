//
//  ApiHandler.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//
import Foundation
import UIKit.UIImage

class WeatherAPI {
    let MAIN = "https://www.metaweather.com/"
    let SEARCH = "api/location/search/?query="
    let LOCATION = "api/location/"
    let IMG = "static/img/weather/png/"
    
    func getWeatherForLocation(locationId: String, callback: @escaping (_: CityWeather) -> Void) {
        let url = URL(string: MAIN + LOCATION + "\(locationId)/")
        if url == nil { return }
        
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url!, completionHandler: {
            (data, urlResponse, error) in
            
            if error != nil {
                print("error [ApiHandler->getLocationForecast()]: \(String(describing: error))")
                
                return
            }
            
            if data == nil {
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                let forecast = CityWeather(data: jsonObject!)
                callback(_: forecast)
                
            } catch _ {
                return
            }
        })
        
        dataTask.resume()
    }
    
    func getCityForWeather(cityName: String, callback: @escaping (_: [CityModel]) -> Void) {
        let url = URL(string: MAIN + SEARCH + "\(cityName)")
        if url == nil { return }
        let urlSession = URLSession.shared
        
        let dataTask = urlSession.dataTask(with: url!, completionHandler: {
            (data, urlResponse, error) in
            
            if error != nil {
                print("Error (findCity): \(String(describing: error))")
                return
            }
            
            if data == nil {
                return
            }
            
            do {
                let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]]
                
                var cities: [CityModel] = []
                
                for subObject in jsonObject! {
                    
                    cities.append(CityModel(jsonData: subObject))
                }
                
                callback(_: cities)
            } catch _ {
                return
            }
        })
        
        dataTask.resume()
    }
    
}
