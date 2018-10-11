//
//  ViewController.swift
//  WeatherApp
//
//  Created by YU on 2018/10/7.
//  Copyright © 2018 ameyo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreLocation


class ViewController: UIViewController,delegateProtocal,CLLocationManagerDelegate {
    
    let openWeatherMap = "https://api.openweathermap.org/data/2.5/weather"
    let apiKey = "41eabac85a8eaa0f4890252d94dc38ca"
    
    let weatherDataModel = WeatherDataModel()
    let locatoinManager = CLLocationManager()
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let latitude = String(24.7973604)
//        let longitude = String(120.9911356)
//
//        let inputs : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : apiKey]
//
//        SVProgressHUD.showInfo(withStatus: "Loading...")
//        getWeatherData(url: openWeatherMap, keys: inputs)
        

        locatoinManager.delegate = self
        locatoinManager.desiredAccuracy = kCLLocationAccuracyBest

        //用戶存取位址
        if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.notDetermined {
            locatoinManager.requestWhenInUseAuthorization()
        }

        locatoinManager.startUpdatingLocation()
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations)
        
        if let location : CLLocation = locations[0] {
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let inputs : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : apiKey]
            
            SVProgressHUD.showInfo(withStatus: "Loading...")
            getWeatherData(url: openWeatherMap, keys: inputs)
        }
    }
    
    func getWeatherData(url: String, keys:[String : String]) {
        
        Alamofire.request(url, method: HTTPMethod.get, parameters: keys, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let weatherJSONData : JSON = JSON(response.result.value)
                //print(weatherJSONDate)
                print("Get data form server")
                self.updataWeatherData(json: weatherJSONData)
            } else {
                print("Could not got data. Error \(String(describing: response.result.error))")
                }
            }
        }
    
    //Model
    func updataWeatherData(json: JSON) {
        
        if let temperature = json["main"]["temp"].double {
            
            weatherDataModel.temperature = Int(temperature - 273.15)
            weatherDataModel.city = json["name"].stringValue
            weatherDataModel.condition = json["weather"][0]["id"].intValue
            weatherDataModel.weatherIconName = weatherDataModel.updataWeatherIcon(conditionId: weatherDataModel.condition)
            
//            print(weatherDataModel.temperature)
//            print(weatherDataModel.city)
//            print(weatherDataModel.condition)
//            print(weatherDataModel.weatherIconName)
            
            updataUI()
          
        } else {
            cityLabel.text = "無法獲取資料"
        }
    }
    
    func updataUI() {

        temperatureLabel.text = String(weatherDataModel.temperature)
        weatherIcon.image = UIImage(named: weatherDataModel.weatherIconName)
        cityLabel.text = weatherDataModel.city
        
        SVProgressHUD.dismiss()
        
    }
    
    func newCityName(city: String) {
        
        print(city)
        let q_city : [String : String] = ["q" : city, "appid" : apiKey]
        
        SVProgressHUD.showInfo(withStatus: "加載中...")
        getWeatherData(url: openWeatherMap, keys: q_city)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoSecondView" {
            
            let destination = segue.destination as! SecondViewController
            destination.delegate = self
        }
    }
        
}



