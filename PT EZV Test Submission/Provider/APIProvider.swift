//
//  APIProvider.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import Foundation
import Alamofire

public let baseUrl = "https://dummyjson.com/products"

class ApiProvider {
  static let shared: ApiProvider = ApiProvider()
  private init() { }
  
  func get(url: String, completion: @escaping (Result<Data, Error>) -> Void) {
    AF.request(
      url,
      method: .get,
      encoding: URLEncoding.default
    ).responseData { response in
      switch response.result {
      case .success(let data):
        completion(.success(data))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }
}
