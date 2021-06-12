//
//  ViewController.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 17.05.2021.
//

import UIKit
import CoreLocation
import RxSwift

class MainViewController: UIViewController {
  
  @IBOutlet private weak var temperatureLabel: UILabel!
  @IBOutlet private weak var textField: UITextField!
  @IBOutlet weak var gifView: UIImageView!
  @IBOutlet weak var conditionImageView: UIImageView!
  
  private let viewModel = MainViewModel()
  private var disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.gifView.loadGif(name: Constants.Gif.name)
    self.textField.delegate = self
    self.setupHidekeyboardOnTasp()
    self.viewModel.locationManager.delegate = self
    self.setupBindings()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  func setupBindings() {
    self.viewModel.temperature
      .bind(to: self.temperatureLabel.rx.text)
      .disposed(by: disposeBag)
    
    self.viewModel.name
      .bind(to: self.textField.rx.text)
      .disposed(by: disposeBag)
    
    self.viewModel.icon
      .bind(to: self.conditionImageView.rx.image)
      .disposed(by: disposeBag)
  }
  
  private func getTemperatureFor(city: String) {
    self.viewModel.getTemperatureFor(city: city)
  }
  
  private func getTemperatureFor(location: CLLocationCoordinate2D) {
    self.viewModel.getTemperatureFor(location: location)
  }
  
  private func requestAthorization() {
    self.viewModel.requestAthorization()
  }
  
  @IBAction private func onSearchButtonPressed(_ sender: Any) {
    guard let text = self.textField.text, !text.isEmpty else { return }
    self.getTemperatureFor(city: text)
    self.view.endEditing(true)
  }
  
  @IBAction private func onLocationButtonPressed(_ sender: Any) {
    self.requestAthorization()
  }
  
  @IBAction private func onMapButtonPressed(_ sender: Any) {
    guard let vc = Constants.Storyboard.map.instantiateInitialViewController() as? MapViewController else { return }
    vc.modalPresentationStyle = .fullScreen
    vc.delegate = self
    vc.lastSelectedLocation = self.viewModel.lastselectedlocation
    self.present(vc, animated: true)
  }
  
  @IBAction private func onFavoritesButtonPressed(_ sender: Any) {
    guard let vc = Constants.Storyboard.favorites.instantiateInitialViewController() as? FavouritesViewController else { return }
    self.navigationController?.pushViewController(vc, animated: true)
  }
  
}

// MARK: - CLLocationManagerDelegate

extension MainViewController: CLLocationManagerDelegate {
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    print(error)
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    if let location = locations.last {
      self.getTemperatureFor(location: location.coordinate)
    }
  }
  
}

extension MainViewController: MapViewControllerDelegate {
  
  func didSelectlocation(location: CLLocationCoordinate2D) {
    self.getTemperatureFor(location: location)
    self.viewModel.lastselectedlocation = location
  }
  
}

// MARK: - TextFieldDelegate

extension MainViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
  
}
