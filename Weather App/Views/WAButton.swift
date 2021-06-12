//
//  WAButton.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 23.05.2021.
//

import UIKit

@IBDesignable
class WAButton: UIButton {
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.setupSelf()
  }
  
  private func setupSelf() {
    self.backgroundColor = .systemRed
    self.setTitleColor(.white, for: .normal)
    self.borderWidth = 2
    self.borderColor = .white
  }
  
}
