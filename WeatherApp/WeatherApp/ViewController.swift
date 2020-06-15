//
//  ViewController.swift
//  WeatherApp
//
//  Created by Student on 28/05/2020.
//  Copyright © 2020 MOgarek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var MaxTemp: UITextField!
    @IBOutlet weak var MinTemp: UITextField!
    @IBOutlet weak var WindSpeed: UITextField!
    @IBOutlet weak var WindDirection: UITextField!
    @IBOutlet weak var Pressure: UITextField!
    @IBOutlet weak var ShortDescription: UITextField!
    @IBOutlet weak var Prev: UIButton!
    @IBOutlet weak var Next: UIButton!
    @IBOutlet weak var date: UILabel!
    
    var page : Int = 0
    var dataWeather: [[String:Any]] = []
    
    @IBOutlet weak var weatherImage: UIImageView!
    
    @IBAction func onClickPrev(_ sender: Any) {
        self.page = self.page - 1
        
        if self.page == 0 {
            self.Prev.isEnabled = false
        }
        
        self.Next.isEnabled = true
        self.showDataOnPage(self.page)
    }
    
    @IBAction func onClickNext(_ sender: Any) {
        self.page = self.page + 1
        
        if self.page == self.dataWeather.count {
            self.Next.isEnabled = false
        }
        
        self.Prev.isEnabled = true
        self.showDataOnPage(self.page)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://www.metaweather.com/api/location/search/?query=London")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            
            let json_ = try? JSONSerialization.jsonObject(with: data, options: [])
            let unwrap_json = json_!
            let array_json = unwrap_json as! [Any]
            let casted_json = array_json[0] as! [String:Any]
            
        
            let woeid = String((casted_json["woeid"] as! Int))
            let url_for_city = URL(string: "https://www.metaweather.com/api/location/" + woeid)!
            
            let locTask = URLSession.shared.dataTask(with: url_for_city) {(data, response, error) in
                guard let data = data else { return }
                
                let jsonRs = try? JSONSerialization.jsonObject(with: data, options: [])
                
                let un_json = jsonRs!
                let cast_json = un_json as! [String:Any]
                
                let weather = cast_json["consolidated_weather"]!
                let weather_ = weather as! [Any]
                
                DispatchQueue.main.async {
                    self.dataWeather = weather_ as! [[String:Any]]
                    self.showDataOnPage(0)
                    self.Prev.isEnabled = false
                }
            }
            locTask.resume()
        }
        task.resume()
    }
    
    func showDataOnPage(_ index: Int) {
        if(index < self.dataWeather.count && index >= 0) {
            
            let day = self.dataWeather[index]
            
            self.date.text = (day["applicable_date"] as! String)
            self.Pressure.text = NSString(format: "%.1f", (day["air_pressure"] as! Double)) as String
            self.ShortDescription.text = (day["weather_state_name"] as! String)
            self.MaxTemp.text = NSString(format: "%.1f", (day["max_temp"] as! Double)) as String
            self.MinTemp.text = NSString(format: "%.1f", (day["min_temp"] as! Double)) as String
            self.WindDirection.text = (day["wind_direction_compass"] as! String)
            self.WindSpeed.text = NSString(format: "%.1f", (day["wind_speed"] as! Double)) as String
            
            let url = URL(string: "https://www.metaweather.com/static/img/weather/png/" +  (day["weather_state_abbr"] as! String) + ".png")
            
            let session = URLSession.shared.dataTask(with: url!, completionHandler: {data, response, error in DispatchQueue.main.async {
                guard let data = data else {return}
                
                self.weatherImage.image = UIImage(data: data)
                }})
            session.resume()
        }
    }
}

