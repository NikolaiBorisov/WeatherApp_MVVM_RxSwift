//
//  PersistanceManager.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 07.06.2021.
//

import Foundation

class PersistanceManager {
  
  static let shared = PersistanceManager()
  
  private var userDefaults = UserDefaults(suiteName: Constants.UserDefaults.suiteName)!
  
  var cities: [String] {
    get { return userDefaults.stringArray(forKey: Keys.cities.rawValue) ?? [] }
    set { self.userDefaults.setValue(newValue, forKey: Keys.cities.rawValue)}
  }
  
  private enum Keys: String {
    case cities
  }
  
}
