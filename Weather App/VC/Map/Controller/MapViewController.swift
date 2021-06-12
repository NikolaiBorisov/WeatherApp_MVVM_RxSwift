//
//  MapViewController.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 23.05.2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
  
  @IBOutlet private weak var coordinateLabel: UILabel!
  @IBOutlet private weak var mapView: MKMapView!
  
  weak var delegate: MapViewControllerDelegate?
  var lastSelectedLocation: CLLocationCoordinate2D?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.setupInitialRegionIfNeeded()
  }
  
  private func setupInitialRegionIfNeeded() {
    guard let location = self.lastSelectedLocation else { return }
    let region = MKCoordinateRegion(center: location, latitudinalMeters: 5000, longitudinalMeters: 5000)
    self.mapView.setRegion(region, animated: false)
  }
  
  @IBAction private func onSelectButtonPressed(_ sender: Any) {
    self.delegate?.didSelectlocation(location: self.mapView.centerCoordinate)
    self.dismiss(animated: true)    
  }
  
  @IBAction private func onCloseButtonPressed(_ sender: Any) {
    self.dismiss(animated: true)
  }
  
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
  
  func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
    self.coordinateLabel.text = mapView.centerCoordinate.stringInterpolation
  }
  
}
