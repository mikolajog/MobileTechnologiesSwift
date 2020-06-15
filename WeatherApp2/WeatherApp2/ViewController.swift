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
    
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var conditionsLabel: UILabel!
    @IBOutlet weak var tempMinTextField: UITextField!
    @IBOutlet weak var tempMaxTextField: UITextField!
    @IBOutlet weak var windSpeedTextField: UITextField!
    @IBOutlet weak var windDirTextField: UITextField!
    @IBOutlet weak var airPressureTextField: UITextField!
    @IBOutlet weak var prevBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    
    
    var currentCityForecast: CityForecast! {
        didSet {
            update()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func update() {
        if currentCityForecast.dayNum != 0 {
            prevBtn.isEnabled = true
        } else {
            prevBtn.isEnabled = false
        }
        
        if currentCityForecast.dayNum != currentCityForecast.forecastList.count - 1 {
            nextBtn.isEnabled = true
        } else {
            nextBtn.isEnabled = false
        }
        
        cityNavigationItem.title = currentCityForecast.cityName
        let dailyForecast = currentCityForecast.getDailyForecast()
        currentDateLabel.text = dailyForecast.date
        conditionsLabel.text =  dailyForecast.conditions
        tempMinTextField.text = dailyForecast.tempMin
        tempMaxTextField.text = dailyForecast.tempMax
        windSpeedTextField.text = dailyForecast.windSpeed
        windDirTextField.text = dailyForecast.windDir
        airPressureTextField.text = dailyForecast.airPressure
        iconImageView.image = UIImage(named: dailyForecast.abbrev)
        
        self.setNeedsFocusUpdate()
    }
    
    @IBAction func onprevBtnTouchUp(_ sender: UIButton) {
        currentCityForecast.previousForecast()
        update()
    }
    
    @IBAction func onnextBtnTouchUp(_ sender: UIButton) {
        currentCityForecast.nextForecast()
        update()
    }
    
}


extension ViewController: CitySelectionDelegate {
    func selectedCityForecast(_ forecast: CityForecast) {
        currentCityForecast = forecast
    }
}
