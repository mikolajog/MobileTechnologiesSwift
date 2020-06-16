//
//  CityForecast.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import Foundation

class CityWeather {
    
    var myList = [DayWeather]()
    var numberDayinOrder = Int()
    var nameOfCity = String()
    var idOfCity = String()
    
    init() {
    }
    
    init(data: [String: Any]) {
        
        let daysRawData = data["consolidated_weather"]! as? [[String: Any]]
        
        for dayData in daysRawData! {
            
            myList.append(DayWeather(data: dayData))
        }
        
        numberDayinOrder = 0
        
        nameOfCity = "\(data["title"]!)"
        idOfCity = "\(data["woeid"]!)"
    }
    
    func getDay() -> DayWeather {
        return myList[numberDayinOrder]
    }
    
    func getNext() {
        if numberDayinOrder < myList.count - 1 {
            numberDayinOrder += 1
        }
    }
    
    func getPrev() {
        if numberDayinOrder > 0 {
            numberDayinOrder -= 1
        }
    }
}
