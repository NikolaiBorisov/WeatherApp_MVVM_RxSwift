//
//  Constants.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 19.05.2021.
//

import UIKit

enum Constants {
  
  enum Storyboard {
    static let map: UIStoryboard = UIStoryboard(name: "Map", bundle: nil)
    static let favorites: UIStoryboard = UIStoryboard(name: "Favourites", bundle: nil)
  }
  
  enum Temperature {
    static let oneKelvin: Float = 273.0
  }
  
  enum ApiComponents {
    static let scheme = "https"
    static let host = "api.openweathermap.org"
    static let path = "/data/2.5/weather"
    static let queryItemsName = "appid"
    static let timeoutInterval = 10.0
    static let queryItemsSeparator1 = "&"
    static let queryItemsSeparator2 = "="
    static let apiKey = "b3bffeb203c7788c507e9d19bd2d8538"
  }
  
  enum Placeholder {
    static let textFieldPlaceholder = "Search..."
  }
  
  enum Queue {
    static let queueName = "Weather queue"
  }
  
  enum AlertController {
    static let title = "Добавьте город"
    static let message = "Введите название города"
    static let closeActionTitle = "Close"
    static let saveActionTitle = "Добавить"
  }
  
  enum UserDefaults {
    static let suiteName = "WeatherApp"
  }
  
  enum NSCoder {
    static let fatalError = "init(coder:) has not been implemented"
  }
  
  enum Gif {
    static let name = "weather"
  }
  
  enum Localizable {
    static func degrees(argument: CVarArg) -> String {
      return String(format: NSLocalizedString("degrees", comment: ""), argument)
    }
    
  }
  
  enum Nib {
    
    static let favoritesTableViewCell: NibResource = .init(name: "FavoritesTableViewCell")
    
    struct NibResource {
      private let name: String
      init(name: String) {
        self.name = name
      }
      var nib: UINib {
        return UINib(nibName: self.name, bundle: nil)
      }
      var identifier: String {
        return name
      }
    }
  }
  
}
