//
//  DailyForecast.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import Foundation

class DailyForecast {
    
    var abbrev = String()
    var date = String()
    var conditions = String()
    var tempMin = String()
    var tempMax = String()
    var tempMain = String()
    var windSpeed = String()
    var windDir = String()
    var airPressure = String()
    
    
    
    init(data: [String: Any]) {
        abbrev = changeToString(param: "weather_state_abbr", data: data)
        date = changeToString(param: "applicable_date", data: data)
        conditions = changeToString(param: "weather_state_name", data: data)
        tempMin = roundValue(name: "min_temp", data: data)
        tempMax = roundValue(name: "max_temp", data: data)
        tempMain = roundValue(name: "the_temp", data: data)
        windSpeed = roundValue(name: "wind_speed", data: data)
        windDir = roundValue(name: "wind_direction", data: data)
        airPressure = roundValue(name: "air_pressure", data: data)
    }
    
    private func roundValue(name: String, data: [String: Any]) -> String {
        var theValue = changeToString(param: name, data: data)
        if let dotRange = theValue.range(of: ".") {
            theValue.removeSubrange(dotRange.lowerBound ..< theValue.endIndex)
        }
        return theValue
    }
    
    private func changeToString(param: String, data: [String: Any]) -> String {
        return "\(data[param]!)"
    }
}
