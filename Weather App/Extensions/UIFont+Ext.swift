//
//  UIFont+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 12.06.2021.
//

import UIKit

extension UIFont {
  
  static var textFieldFont: UIFont {
    return UIFont(name: "Avenir Next Medium", size: 30) ?? UIFont.systemFont(ofSize: 30)
  }
  
}
