//
//  CityForecast.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import Foundation

class CityWeather {
    
    var forecastList = [DayWeather]()
    var dayNum = Int()
    var cityName = String()
    var cityId = String()
    
    init() {
    }
    
    init(data: [String: Any]) {
        let daysRawData = data["consolidated_weather"]! as? [[String: Any]]
        
        for dayData in daysRawData! {
            forecastList.append(DayWeather(data: dayData))
        }
        
        dayNum = 0
        cityName = "\(data["title"]!)"
        cityId = "\(data["woeid"]!)"
    }
    
    func getDailyForecast() -> DayWeather {
        return forecastList[dayNum]
    }
    
    func nextForecast() {
        if dayNum < forecastList.count - 1 {
            dayNum += 1
        }
    }
    
    func previousForecast() {
        if dayNum > 0 {
            dayNum -= 1
        }
    }
}
