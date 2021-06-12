//
//  NetworkManager.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 17.05.2021.
//

import Foundation

// api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

class NetworkManager {
  
  static let shared = NetworkManager()
  private let apiKey = Constants.ApiComponents.apiKey
  
  private lazy var decoder: JSONDecoder = {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    return decoder
  }()
  
  private lazy var session: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    return URLSession(configuration: configuration)
  }()
  
  // MARK: - Network request
  
  func request<T: NetworkRequest>(request: T, closure: @escaping (Result<T.Response, Error>) -> Void) {
    guard let urlRequest = request.tryToBuildUrlRequest(with: self.apiKey) else {
      closure(.failure(WAError.Network.failedToCreateURLRequest))
      return
    }
    self.session
      .dataTask(with: urlRequest, completionHandler: { data, _, error in
        if let error = error {
          closure(.failure(error))
          return
        }
        guard let data = data else {
          closure(.failure(WAError.Network.noData))
          return
        }
        guard let response = try? request.decode(data: data, with: self.decoder) else {
          closure(.failure(WAError.Decoding.failedToDecodeData))
          return
        }
        DispatchQueue.main.async {
          closure(.success(response))
        }
      })
      .resume()
  }
  
} 
