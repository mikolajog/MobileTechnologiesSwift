//
//  ApiHandler.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//
import Foundation
import UIKit.UIImage

class ApiHandler {
    let METAWEATHER_API_BASE = "https://www.metaweather.com/"
    let METAWEATHER_API_SEARCH = "api/location/search/?query="
    let METAWEATHER_API_WEATHER = "api/location/"
    let METAWEATHER_API_IMAGE = "static/img/weather/png/"
    
    func getLocationForecast(locationId: String, callback: @escaping (_: CityForecast) -> Void) {
        let url = URL(string: METAWEATHER_API_BASE + METAWEATHER_API_WEATHER + "\(locationId)/")
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
                let forecast = CityForecast(data: jsonObject!)
                callback(_: forecast)
            } catch _ {
                return
            }
        })
        
        dataTask.resume()
    }
    
    func findCity(cityName: String, callback: @escaping (_: [City]) -> Void) {
        let url = URL(string: METAWEATHER_API_BASE + METAWEATHER_API_SEARCH + "\(cityName)")
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
                var cities: [City] = []
                
                for subObject in jsonObject! {
                    cities.append(City(jsonData: subObject))
                }
                
                callback(_: cities)
            } catch _ {
                return
            }
        })
        
        dataTask.resume()
    }
    
}
