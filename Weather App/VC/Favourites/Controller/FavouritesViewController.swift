//
//  FavoritesViewController.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 24.05.2021.
//

import UIKit

import RxSwift
import RxCocoa

class FavouritesViewController: UIViewController {
  
  @IBOutlet private weak var tableView: UITableView!
  
  var viewModel: FavouriteViewModel = FavouriteViewModel()
  private var disposebag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(Constants.Nib.favoritesTableViewCell)
    self.viewModel.getData()
    self.setupBindings()
  }
  
  private func setupBindings() {
    self.viewModel.indexToUpdate
      .bind { [weak self] indexToUpdate in
        self?.tableView.reloadRows(at: [IndexPath(row: indexToUpdate, section: 0)], with: .automatic)
      }
      .disposed(by: disposebag)
  }
  
  @IBAction func onAddButtonPressed(_ sender: Any) {
    let controller = self.createAlertController()
    self.present(controller, animated: true)
  }
  
  private func createAlertController() -> UIAlertController {
    let controller = UIAlertController(
      title: Constants.AlertController.title,
      message: Constants.AlertController.message,
      preferredStyle: .alert
    )
    let closeAction = UIAlertAction(title: Constants.AlertController.closeActionTitle, style: .destructive) { (_) in
      controller.dismiss(animated: true)
    }
    
    let saveAction = UIAlertAction(title: Constants.AlertController.saveActionTitle, style: .default) { [weak self] _ in
      if let textField = controller.textFields?.first,
         let text = textField.text {
        self?.viewModel.addCity(cityName: text) {
          self?.tableView.reloadData()
        }
      }
    }
    controller.addTextField()
    controller.addAction(closeAction)
    controller.addAction(saveAction)
    return controller
  }
  
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension FavouritesViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    let item = self.viewModel.displayItems[indexPath.row]
    (cell as? FavoritesTableViewCell)?.configure(with: item)
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.displayItems.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    return tableView.dequeueReusableCell(withIdentifier: Constants.Nib.favoritesTableViewCell.identifier, for: indexPath)
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if case .delete = editingStyle {
      self.viewModel.delete(at: indexPath.row) { [weak self] in
        self?.tableView.reloadData()
      }
    }
  }
  
}
