//
//  APIClient.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String : AnyObject]

enum APIError: ErrorProtocol {
  case genericError(error: NSError)
  case invalidResponseError
  case badResponseError(response: URLResponse)
  case invalidDataError
}

enum Result<T, Error: ErrorProtocol> {
  case success(T)
  case failure(Error)
}


class APIClient {
  
  //MARK: Private
  
  private var urlSession = URLSession.shared
  
  func getData(fromURL url: URL, completion: (Result<JSONDictionary, APIError>) -> Void) -> URLSessionDataTask? {
    let task = urlSession.dataTask(with: url) { (responseData, response, responseError) in
      if let error = responseError {
        completion(.failure(APIError.genericError(error: error)))
        return
      }
      
      guard let httpResponse = response as? HTTPURLResponse else {
        completion(.failure(APIError.invalidResponseError))
        return
      }
      
      guard (200...299 ~= httpResponse.statusCode) else {
        completion(.failure(APIError.badResponseError(response: httpResponse)))
        return
      }
      
      guard let data = responseData else {
        completion(.failure(APIError.invalidDataError))
        return
      }
      
      do {
        let result = try JsonDataParser.parse(withData: data)
        
        completion(.success(result))
      } catch {
        completion(.failure(APIError.invalidDataError))
      }
    }
    
    task.resume()
    
    return task
  }
}
