//
//  WAErrors.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 19.05.2021.
//

import Foundation

enum WAError {
  
  enum Network: String, Error {
    case failedToCreateURLRequest
    case noData
  }
  
  enum Decoding: String, Error {
    case failedToDecodeData
  }
}
