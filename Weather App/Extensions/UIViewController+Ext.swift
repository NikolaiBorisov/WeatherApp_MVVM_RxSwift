//
//  UIViewController+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 23.05.2021.
//

import UIKit

extension UIViewController {
  
  func setupHidekeyboardOnTasp() {
    self.view.addGestureRecognizer(self.endEditingRecognizer())
    self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
  }
  
  private func endEditingRecognizer() -> UIGestureRecognizer {
    return UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
  }
  
}
