//
//  DailyForecast.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import Foundation

class DayWeather {
    
    var img = String()
    var date = String()
    var conditions = String()
    var tempMin = String()
    var tempMax = String()
    var tempMain = String()
    var speedWind = String()
    var directionWind = String()
    var pressure = String()
    
    
    
    init(data: [String: Any]) {
        img = toStringChange(param: "weather_state_abbr", data: data)
        date = toStringChange(param: "applicable_date", data: data)
        conditions = toStringChange(param: "weather_state_name", data: data)
        tempMin = makeRoundingOfVal(name: "min_temp", data: data)
        tempMax = makeRoundingOfVal(name: "max_temp", data: data)
        tempMain = makeRoundingOfVal(name: "the_temp", data: data)
        speedWind = makeRoundingOfVal(name: "wind_speed", data: data)
        directionWind = makeRoundingOfVal(name: "wind_direction", data: data)
        pressure = makeRoundingOfVal(name: "air_pressure", data: data)
    }
    
    private func makeRoundingOfVal(name: String, data: [String: Any]) -> String {
        var theValue = toStringChange(param: name, data: data)
        
        if let dotRange = theValue.range(of: ".") {
            
            theValue.removeSubrange(dotRange.lowerBound ..< theValue.endIndex)
        }
        return theValue
    }
    
    private func toStringChange(param: String, data: [String: Any]) -> String {
        return "\(data[param]!)"
    }
}
