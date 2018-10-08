//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by YU on 2018/10/8.
//  Copyright © 2018 ameyo. All rights reserved.
//

import Foundation

class WeatherDataModel {
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    //天氣圖示判斷
    func updataWeatherIcon(conditionId : Int) -> String {
        
        switch condition {
        case 0...232:
            return "thunderstorm"

        case 300...531:
            return "rain"

        case 600...655:
            return "snow"

        case 701...781:
            return "mist"

        case 800:
            return "sunny"

        case 801...804:
            return "wind"
            
        default:
            return "sunny"
        }
    }
    
}
