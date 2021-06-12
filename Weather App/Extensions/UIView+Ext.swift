//
//  UIView+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 17.05.2021.
//

import UIKit

extension UIView {
  
  @IBInspectable var cornerRadius: CGFloat {
    get { return self.layer.cornerRadius }
    set { self.layer.cornerRadius = newValue }
  }
  
  @IBInspectable var borderWidth: CGFloat {
    get { return self.layer.borderWidth }
    set { self.layer.borderWidth = newValue }
  }
  
  @IBInspectable var borderColor: UIColor? {
    get { return UIColor(cgColor:self.layer.borderColor!) }
    set { self.layer.borderColor = newValue?.cgColor }
  }
  
}
