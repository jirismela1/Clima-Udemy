//
//  WeatherManager.swift
//  Clima
//
//  Created by Jirka  on 24/02/2020.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation


protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWitError(error: Error)
}

struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=372528dd84a37791d01fcd3f8de42427&units=metric"
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequst(urlString: urlString)
    }
    
    func fetchWeather(lat: Double,lon: Double){
        let urlString = "\(weatherURL)&lat=\(lat)&lon=\(lon)"
        performRequst(urlString: urlString)
    }
    
    func performRequst(urlString: String){
//            1. Creat URL
        if let url = URL(string: urlString){
//            2. Creat a URLSession
            let session = URLSession(configuration: .default)
//            3. Give  the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWitError(error: error!)
                    return
                }
                
                if let safeData = data{
                    if let weatherVC = self.parseJSON(weatherData: safeData){
                        self.delegate?.didUpdateWeather(weather: weatherVC)
                    }
                    
                }
            }
            
//            4.Start the task
            task.resume()
        }
    }
    
    func parseJSON(weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
            return weather
        }catch{
            
            delegate?.didFailWitError(error: error)
            return nil
        }
    }
    
}
