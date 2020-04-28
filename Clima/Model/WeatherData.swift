//
//  WeatherData.swift
//  Clima
//
//  Created by Jirka  on 24/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable{
    
    let name: String
    let weather: [Weather]
    let main: Main
}

struct Weather: Codable{
    let id: Int
    let icon: String
}

struct Main: Codable {
    let temp: Double
}
