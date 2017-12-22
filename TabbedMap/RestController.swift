//
//  RestController.swift
//  TabbedMap
//
//  Created by Ulrik Nilsson on 2017-12-13.
//  Copyright © 2017 Ulrik Nilsson. All rights reserved.
//

import Foundation


class RestController {
    
    var formatter: DateFormatter
    var decoder: JSONDecoder
    var encoder: JSONEncoder
    
    init() {
        formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd-HH:mm:ss"
        decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(formatter)
        encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
    }
    
    func registerSettingsBundle(){
        let appDefaults = [String:AnyObject]()
        UserDefaults.standard.register(defaults: appDefaults)
    }
    
    
    
    func post<T, V>(_ type: T, completion: @escaping (V?) -> Void) where T:Codable, T:Endpoint, V:Codable  {
        guard let rootUrl = UserDefaults.standard.string(forKey: "url") else {
            completion(nil)
            return
        }
        
        
        let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
        let url = URL(string: T.endpoint(url: rootUrl))
         print("url\(rootUrl)")
        
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(formatter)
        do {
            let asJSON = try encoder.encode(type)
            urlRequest.httpBody = asJSON
        } catch {
            print(error)
            completion(nil)
        }
        
        let task = session.dataTask(with: urlRequest, completionHandler: {
            (data, response, error) in
            guard let data = data else {
                completion(nil)
                return
            }
            guard  let json = try? self.decoder.decode(V.self, from: data) else {
                completion(nil)
                return
            }
            completion(json)
            return
        })
        task.resume()
    }
}
