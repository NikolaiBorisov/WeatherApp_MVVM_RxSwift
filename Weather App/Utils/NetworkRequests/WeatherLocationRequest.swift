//
//  WeatherLocationRequest.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 19.05.2021.
//

import Foundation

struct WeatherLocationRequest:NetworkRequest {
  
  typealias Response = WeatherLocationDTO
  
  var path: String
  
  init(lat: Double, lon: Double) {
    self.path = "lat=\(lat)&lon=\(lon)"
  }
  
}

struct WeatherLocationDTO: Codable {
  
  let name: String
  let main: Main
  let weather: [Weather]
  
  struct Main: Codable {
    @CelciusTemperature var temp: Int
  }
  
  struct Weather: Codable {
    let id: Int
    let description: String
        
    var type: WeatherType {
      switch id {
      case 200...232:
        return .cloudBolt
      case 300...321:
        return .cloudDrizzle
      case 500...531:
        return .cloudRain
      case 600...622:
        return .cloudSnow
      case 701...781:
        return .cloudFog
      case 800:
        return .sunMax
      case 801...804:
        return .cloudBolt
      default:
        return .cloud
      }
    }
  }
  
}
