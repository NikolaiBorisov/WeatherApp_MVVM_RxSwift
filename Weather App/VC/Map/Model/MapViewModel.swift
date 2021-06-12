//
//  MapVCModel.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 08.06.2021.
//

import Foundation
import MapKit

class MapViewModel {
  
  weak var delegate: MapViewControllerDelegate?
  var lastSelectedLocation: CLLocationCoordinate2D?
  
  private func setupInitialRegionIfNeeded() {
    guard let location = self.lastSelectedLocation else { return }
    let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
    //self.mapView.setRegion(region, animated: false)
  }
  
}
