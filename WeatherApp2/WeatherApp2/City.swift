//
//  City.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//


import Foundation

class City {
    
    let name: String
    let id: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
    
    init(jsonData: [String: Any]) {
        self.name = "\(jsonData["title"]!)"
        self.id = "\(jsonData["woeid"]!)"
    }
}
