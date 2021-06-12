//
//  WeatherCityNetworkRequest.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 19.05.2021.
//

import UIKit

struct WeatherCityNetworkRequest: NetworkRequest {
  
  typealias Response = WeatherCityDTO
  
  var path: String
  
  init(city: String) {
    self.path = "q=\(city)"
  }
  
}

struct WeatherCityDTO: Codable {
  
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

enum WeatherType {
  case cloudBolt
  case cloudDrizzle
  case cloudRain
  case cloudSnow
  case cloudFog
  case sunMax
  case cloud
}

extension WeatherType {
  var image: UIImage? {
    switch self {
    case .cloudBolt: return UIImage(systemName: "cloud.bolt")
    case .cloudDrizzle: return UIImage(systemName: "cloud.drizzle")
    case .cloudRain: return UIImage(systemName: "cloud.rain")
    case .cloudSnow: return UIImage(systemName: "cloud.snow")
    case .cloudFog: return UIImage(systemName: "cloud.fog")
    case .sunMax: return UIImage(systemName: "sun.max")
    default: return UIImage(systemName: "cloud")
    }
  }
}
