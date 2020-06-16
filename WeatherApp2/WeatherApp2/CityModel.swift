//
//  City.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//


import Foundation

class CityModel {
    
    let nameOfCity: String
    let idOfCity: String
    
    init(name: String, id: String) {
        
        self.nameOfCity = name
        self.idOfCity = id
    }
    
    init(jsonData: [String: Any]) {
        
        self.nameOfCity = "\(jsonData["title"]!)"
        
        self.idOfCity = "\(jsonData["woeid"]!)"
    }
}
