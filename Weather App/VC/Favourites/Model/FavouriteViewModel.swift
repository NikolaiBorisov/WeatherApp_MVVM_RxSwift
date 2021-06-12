//
//  FavouriteVCModel.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 08.06.2021.
//

import UIKit
import RxCocoa
import RxSwift

class FavouriteViewModel {
  
  var indexToUpdate = PublishSubject<Int>()
  
  private lazy var queue: OperationQueue = {
    let queue = OperationQueue()
    queue.name = Constants.Queue.queueName
    queue.qualityOfService = .utility
    queue.maxConcurrentOperationCount = 3
    return queue
  }()
  
  lazy var displayItems: [FavoritesDisplayItem] = {
    let cities = PersistanceManager.shared.cities
    return cities.map { FavoritesDisplayItem(city: $0, temperature: nil) }
  }()
  
  // MARK: - Get data for city
  
  func getData() {
    for city in self.displayItems {
      self.queue.addOperation { [weak self] in
        guard let self = self else { return }
        self.getTemperatureFor(city.city) { temperature in
          if let index = self.displayItems.firstIndex(where: { $0.city == city.city} ) {
            self.displayItems[index].temperature = temperature
            self.indexToUpdate.onNext(index)
          }
        }
      }
    }
  }
  
  // MARK: - Add city
  
  func addCity(cityName: String, reloadClosure: @escaping () -> Void) {
    DispatchQueue.main.async { [weak self] in
      guard let self = self else { return }
      self.displayItems.append(.init(city: cityName, temperature: nil))
      reloadClosure()
    }
    
    DispatchQueue.global(qos: .userInitiated).async { [weak self] in
      guard let self = self else { return }
      var items = PersistanceManager.shared.cities
      items.append(cityName)
      PersistanceManager.shared.cities = items
      
      self.getTemperatureFor(cityName) { temperature in
        if let index = self.displayItems.firstIndex(where: { $0.city == cityName} ) {
          self.displayItems[index].temperature = temperature
          self.indexToUpdate.onNext(index)
        }
      }
    }
  }
  
  // MARK: - Delete city from UserDefaults
  
  func delete(at row: Int, reloadClosure: @escaping () -> Void) {
    
    self.displayItems.remove(at: row)
    let items = displayItems.map { $0.city }
    PersistanceManager.shared.cities = items
    
    DispatchQueue.main.async {
      reloadClosure()
    }
  }
  
  // MARK: - GetTemperatureFor city
  
  private func getTemperatureFor(_ city: String, completionHandler: @escaping (String) -> Void) {
    let req = WeatherCityNetworkRequest(city: city)
    NetworkManager.shared.request(request: req) {
      switch $0 {
      case .failure(let error): print(error)
      case .success(let result):
        completionHandler(Constants.Localizable.degrees(argument: result.main.temp))
      }
    }
  }
  
}
