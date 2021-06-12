//
//  NetworkRequest.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 17.05.2021.
//

import Foundation

protocol NetworkRequest {
  var path: String { get }
  associatedtype Response = [String : Any]
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response
}
