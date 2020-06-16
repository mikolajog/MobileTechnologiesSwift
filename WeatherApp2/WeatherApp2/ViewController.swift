//
//  ViewController.swift
//  WeatherApp2
//
//  Created by Student on 15/06/2020.
//  Copyright © 2020 MikolajOgarek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cityNavigationItem: UINavigationItem!
    
    @IBOutlet weak var currDate: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var conditions: UILabel!
    @IBOutlet weak var tempMin: UITextField!
    @IBOutlet weak var tempMax: UITextField!
    @IBOutlet weak var speedWind: UITextField!
    @IBOutlet weak var direction: UITextField!
    @IBOutlet weak var pressure: UITextField!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    var currCityWeather: CityWeather! {
        didSet {
            
            do_updates()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func do_updates() {
        if currCityWeather.numberDayinOrder != 0 {
            previousButton.isEnabled = true
        }
        else {
            previousButton.isEnabled = false
        }
        
        if currCityWeather.numberDayinOrder != currCityWeather.myList.count - 1 {
            nextButton.isEnabled = true
        }
        else {
            nextButton.isEnabled = false
        }
        
        cityNavigationItem.title = currCityWeather.nameOfCity
        let day = currCityWeather.getDay()
        
        currDate.text = day.date
        conditions.text =  day.conditions
        tempMin.text = day.tempMin
        tempMax.text = day.tempMax
        speedWind.text = day.speedWind
        direction.text = day.directionWind
        pressure.text = day.pressure
        img.image = UIImage(named: day.img)
        
        self.setNeedsFocusUpdate()
    }
    
    @IBAction func onprevBtnTouchUp(_ sender: UIButton) {
        currCityWeather.getPrev()
        do_updates()
    }
    
    @IBAction func onnextBtnTouchUp(_ sender: UIButton) {
        currCityWeather.getNext()
        do_updates()
    }
    
}


extension ViewController: CitySelectionDelegate {
    func selectedCityForecast(_ forecast: CityWeather) {
        currCityWeather = forecast
    }
}
