//
//  HomeViewModel.swift
//  CheckMyWeather
//
//  Created by Ashish Chauhan  on 24/04/2023.
//

import Foundation

class HomeViewModel {
    
    func fetchWeatherReport(for city: String, completion: @escaping ([String: Any]?, Error?) -> Void) {
        var service = NetworkService(urlPath: "https://api.weatherapi.com/v1/current.json", type: "GET")
        service.addParams(params: ["key": "902da679f139474db46152610232404",
                                   "q":city,
                                   "aqi":"no"])
        
        guard let request = service.urlRequest else { return }
        service.executeRequest(request: request) { response, error in
           completion(response, error)
        }
    }
    
}
