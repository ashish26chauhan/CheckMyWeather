//
//  NetworkRequest.swift
//  CheckMyWeather
//
//  Created by Ashish Chauhan  on 24/04/2023.
//

import Foundation

struct NetworkService {
    var urlPath: String?
    var type: String?
    
    init(urlPath: String? = nil, type: String? = nil) {
        self.urlPath = urlPath
        self.type = type
    }
    
    var urlRequest: URLRequest? {
        if let urlStr = urlPath, let url = URL(string: urlStr) {
            return URLRequest(url: url)
        }
        return nil
    }
    
    mutating func addParams(params: [String:Any]?) {
        guard let qParams = params else { return }
        var qString = "?"
        
        for (key, values) in qParams {
            if qString.count > 1 {
                qString.append("&")
            }
            qString.append("\(key)=\(values)")
        }
        
        if let url = self.urlPath {
            self.urlPath = url + qString
        }
    }
}

extension NetworkService {
    func executeRequest(request: URLRequest, completion: @escaping ([String: Any]?, Error?) -> Void) {
         let session = URLSession(configuration: .default)
         
         session.dataTask(with: request) { data, response, error in
             
             if (error == nil) {
                 if let data = data {
                     do {
                         if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                             if let location = json["location"] as? [String: Any], let city = location["name"] {
                                 print("City searched - ", city)
                             }
                             completion(json, error)
                         }else {
                             completion(nil, error)
                         }
                     }
                 }
             }
         }.resume()
     }
}
