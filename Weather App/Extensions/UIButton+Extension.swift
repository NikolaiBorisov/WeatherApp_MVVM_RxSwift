//
//  UIButton+Extension.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 08.06.2021.
//

import UIKit

class WAButtonCodeOnly: UIButton {
  
  enum WAButtonType: String {
    case Favourites
    case Map
    case Location
    case Search
  }
  
  init(type: WAButtonType) {
    super.init(frame: .zero)
    self.layer.cornerRadius = 5
    self.layer.borderWidth = 2
    self.layer.borderColor = UIColor.white.cgColor
    self.backgroundColor = .systemRed
    self.setTitle(type.rawValue, for: .normal)
  }
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
}

class WATextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: .zero)
    self.placeholder = Constants.Placeholder.textFieldPlaceholder
    self.textAlignment = .center
    self.backgroundColor = .white
    self.textColor = .label
    self.layer.cornerRadius = 6
    self.font = .textFieldFont
  }
  
  required init?(coder: NSCoder) {
    fatalError(Constants.NSCoder.fatalError)
  }
  
}
