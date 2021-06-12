//
//  UITableView+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 07.06.2021.
//

import UIKit

extension UITableView {
  
  func register(_ resource: Constants.Nib.NibResource) {
    self.register(resource.nib, forCellReuseIdentifier: resource.identifier)
  }
  
}
