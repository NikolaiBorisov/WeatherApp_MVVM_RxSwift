//
//  FavoritesTableViewCell.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 24.05.2021.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
  
  @IBOutlet private weak var cityNameLabel: UILabel!
  @IBOutlet private weak var temperatureLabel: UILabel!
  
  func configure(with item: FavoritesDisplayItem) {
    self.cityNameLabel.text = item.city
    self.temperatureLabel.text = item.temperature
  }
  
}
