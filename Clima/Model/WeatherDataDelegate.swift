//
//  WeatherDataDelegate.swift
//  Clima
//
//  Created by Jirka  on 24/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherDataDelegate {
    var name: String {get}
    var weatherI: Int {get}
    var temp: Int {get}
}
