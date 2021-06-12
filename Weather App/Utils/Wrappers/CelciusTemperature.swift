//
//  CelciusTemperature.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 19.05.2021.
//

import Foundation

@propertyWrapper
struct CelciusTemperature: Codable {
  
  var wrappedValue: Int {
    return (Int(value - Constants.Temperature.oneKelvin))
  }
  var value: Float
  
  init(from decoder: Decoder) throws {
    let container = try decoder.singleValueContainer()
    self.value = try container.decode(Float.self)
  }
  
}

