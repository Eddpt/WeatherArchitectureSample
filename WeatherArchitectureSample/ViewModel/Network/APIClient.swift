//
//  APIClient.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

public typealias JSONDictionary = [String : AnyObject]

enum APIError: ErrorType {
  case GenericError(error: NSError)
  case InvalidResponseError
  case BadResponseError(response: NSURLResponse)
  case InvalidDataError
}

enum Result<T, Error: ErrorType> {
  case Success(T)
  case Failure(Error)
}


class APIClient {
  
  //MARK: Private
  
  private var urlSession = NSURLSession.sharedSession()
  
  func getData(fromURL url: NSURL, completion: Result<JSONDictionary, APIError> -> Void) -> NSURLSessionDataTask? {
    let task = urlSession.dataTaskWithURL(url) { (responseData, response, responseError) in
      if let error = responseError {
        completion(.Failure(APIError.GenericError(error: error)))
        return
      }
      
      guard let httpResponse = response as? NSHTTPURLResponse else {
        completion(.Failure(APIError.InvalidResponseError))
        return
      }
      
      guard (200...299 ~= httpResponse.statusCode) else {
        completion(.Failure(APIError.BadResponseError(response: httpResponse)))
        return
      }
      
      guard let data = responseData else {
        completion(.Failure(APIError.InvalidDataError))
        return
      }
      
      do {
        let result = try JsonDataParser.parse(withData: data)
        
        completion(.Success(result))
      } catch {
        completion(.Failure(APIError.InvalidDataError))
      }
    }
    
    task.resume()
    
    return task
  }
}