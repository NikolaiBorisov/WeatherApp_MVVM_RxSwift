//
//  UIImageView+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 12.06.2021.
//

import UIKit

extension UIImageView {
  
  public func loadGif(name: String) {
    DispatchQueue.global().async {
      let image = UIImage.gif(name: name)
      DispatchQueue.main.async {
        self.image = image
      }
    }
  }
  
  @available(iOS 9.0, *)
  public func loadGif(asset: String) {
    DispatchQueue.global().async {
      let image = UIImage.gif(asset: asset)
      DispatchQueue.main.async {
        self.image = image
      }
    }
  }
  
}
