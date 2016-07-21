//
//  WeatherAPIClient.swift
//  WeatherArchitectureSample
//
//  Created by Heisenberg on 14/06/2016.
//  Copyright © 2016 Weather. All rights reserved.
//

import Foundation

final class WeatherAPIClient: APIClient {
  
  //MARK: Private
  private static let numberOfRecords = 7
  
  /**
   Method responsible for starting a request to the Weather API using the provided City
   
   - parameter city: String with the name of the City to be requested
   */
  func fetchWeatherForecast(forCity city: String, weatherPersistence: WeatherPersistence)  -> URLSessionDataTask? {
    
    guard let url = URL.defaultWeatherURL.addComponent(withName: "q", value: city) else {
      return nil
    }
    
    return getData(fromURL: url, completion: { (result: Result<JSONDictionary, APIError>) in
      switch(result) {
      case let .success(data):
        weatherPersistence.persistWeather(withData: data)
        
      case let .failure(APIError.genericError(error: error)):
        print("Error while requesting the API \(error)")
        
      case let .failure(APIError.badResponseError(response: response)):
        print("Bad response \(response)")
      
      case .failure(_):
        print("Failed requesting the API")
      }
    })
  }  
}

private extension URL {
  private static var defaultWeatherURL: URL {
    var url = URL(string: GlobalConfiguration.weatherAPIURLString)
    url = url?.addComponent(withName: "mode", value: "json")
    url = url?.addComponent(withName: "units", value: "metric")
    url = url?.addComponent(withName: "cnt", value: String(WeatherAPIClient.numberOfRecords))
    url = url?.addComponent(withName: "APPID", value: GlobalConfiguration.weatherAPIKey)
    
    return url!
  }
}
