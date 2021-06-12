//
//  CLLocationCoordinate2D.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 23.05.2021.
//

import Foundation
import MapKit

extension CLLocationCoordinate2D {
  
  var stringInterpolation: String {
    return "\(Float(latitude)),\(Float(longitude))"
  }
  
}
