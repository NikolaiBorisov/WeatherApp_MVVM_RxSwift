//
//  MapViewControllerDelegate.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 23.05.2021.
//

import Foundation
import MapKit

protocol MapViewControllerDelegate: AnyObject {
  func didSelectlocation(location: CLLocationCoordinate2D)
}
