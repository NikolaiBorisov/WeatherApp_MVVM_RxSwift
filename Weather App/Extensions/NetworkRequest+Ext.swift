//
//  NetworkRequest+Ext.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 17.05.2021.
//

import Foundation

extension NetworkRequest {
  
  func tryToBuildUrlRequest(with apiKey: String) -> URLRequest? {
    
    var components = URLComponents()
    components.scheme = Constants.ApiComponents.scheme
    components.host = Constants.ApiComponents.host
    components.path = Constants.ApiComponents.path
    
    var queryItems: [URLQueryItem] = [.init(name: Constants.ApiComponents.queryItemsName, value: apiKey)]
    queryItems.append(contentsOf: self.queryItems)
    components.queryItems = queryItems
    
    guard let url = components.url else { return nil }
    
    var request = URLRequest(url: url)
    request.timeoutInterval = Constants.ApiComponents.timeoutInterval
    
    return request
  }
  
}

fileprivate extension NetworkRequest {
  
  var queryItems: [URLQueryItem] {
    var queryItems = [URLQueryItem]()
    self.path.components(separatedBy: Constants.ApiComponents.queryItemsSeparator1).forEach {
      let queryComponents = $0.components(separatedBy: Constants.ApiComponents.queryItemsSeparator2)
      queryItems.append(.init(name: queryComponents[0], value: queryComponents[1]))
    }
    return queryItems
  }
  
}

extension NetworkRequest where Response == [String : Any] {
  
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response {
    guard !data.isEmpty else { return [:] }
    guard let response = try JSONSerialization.jsonObject(with: data, options: []) as? Response else {
      throw WAError.Decoding.failedToDecodeData
    }
    return response
  }
  
}

extension NetworkRequest where Response: Decodable {
  
  func decode(data: Data, with decoder: JSONDecoder) throws -> Response {
    return try decoder.decode(Response.self, from: data)
  }
  
}
