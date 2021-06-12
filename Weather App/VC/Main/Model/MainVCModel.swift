//
//  MainVCModel.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 08.06.2021.
//

import Foundation
import CoreLocation
import RxSwift
import RxCocoa

class MainViewModel {
  
  var temperature = PublishSubject<String>()
  var name = PublishSubject<String>()
  var error = PublishSubject<String>()
  var icon = PublishSubject<UIImage?>()
  var lastselectedlocation: CLLocationCoordinate2D?
  let locationManager = CLLocationManager()
  
  // MARK: - GetTemperatureFor city
  
  func getTemperatureFor(city: String) {
    let req = WeatherCityNetworkRequest(city: city)
    NetworkManager.shared.request(request: req) { [weak self] completion in
      switch completion {
      case .failure(let error): print(error)
      case .success(let result):
        self?.temperature.onNext(Constants.Localizable.degrees(argument: result.main.temp))
        self?.icon.onNext(result.weather.first?.type.image)
      }
    }
  }
  
  // MARK: - GetTemperatureFor location
  
  func getTemperatureFor(location: CLLocationCoordinate2D) {
    let req = WeatherLocationRequest(lat: location.latitude, lon: location.longitude)
    NetworkManager.shared.request(request: req) { [weak self] completion in
      switch completion {
      case .failure(let error): print(error)
      case .success(let result):
        self?.name.onNext(result.name)
        self?.temperature.onNext(Constants.Localizable.degrees(argument: result.main.temp))
        self?.icon.onNext(result.weather.first?.type.image)
      }
    }
  }
  
  // MARK: - RequestAthorization
  
  func requestAthorization() {
    let authStatus = self.locationManager.authorizationStatus
    guard authStatus == .authorizedAlways || authStatus == .authorizedWhenInUse else {
      self.locationManager.requestWhenInUseAuthorization()
      return
    }
    self.locationManager.requestLocation()
  }
  
}
