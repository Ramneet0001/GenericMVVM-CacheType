//
//  ApiManager.swift
//  genericModelMVVM
//
//  Created by STUser on 26/06/19.
//  Copyright © 2019 abc. All rights reserved.
//

import UIKit
import Foundation

protocol ApiMethods {
    
    
}

class ApiManager {
    
    
    // MARK: Call Api service
    
    func callApiService<T: Codable>(urlString: String, method: String, headers:NSDictionary, params:NSDictionary, typeModel: T.Type, completion: @escaping (_ returnModel: T?, _ returnError: Error?, _ reverData: Data?) -> Void ) {
     
        getJSONFromURL(urlString: urlString, method: method, headers: headers, params: params) { (data, error) in
            
            guard let data = data, error == nil else {
                print("Failed to get data")
                return completion(nil, error, nil)
            }
            
            self.getDecodedModelStruct(responseData: data, typeModel: typeModel, completion: { (decoded, error, revertedData) in
               
                if let error = error {
                    print("Failed to convert data")
                    return completion(nil, error, data)
                }
                return completion(decoded, nil, data)
                
            }) // getDecodedModelStruct @End
            
        } // getJSONFromURL @End
        
       }
    
    }




extension ApiManager{
    
    //MARK: URLSession
    
    private func getJSONFromURL(urlString: String, method: String, headers:NSDictionary, params:NSDictionary, completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
     
        
        let request = NSMutableURLRequest(url: NSURL(string: urlString)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        
        request.httpMethod = method
        request.allHTTPHeaderFields = headers as? [String : String]
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            guard error == nil else {
                print("Error calling api")
                return completion(nil, error)
            }
            guard let responseData = data else {
                print("Data is nil")
                return completion(nil, error)
            }
            completion(responseData, nil)
            
        })
        
        dataTask.resume()
    }
    
    
    //MARK: Convert data to Model
    
    private func getDecodedModelStruct<T: Codable>(responseData: Data, typeModel: T.Type, completion: @escaping (_ returnModel: T?, _ error: Error?, _ revertData: Data) -> Void) {
        
        print(String(data: responseData, encoding: .utf8)!)
        
       
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let returnModel = try decoder.decode(typeModel.self, from: responseData)
            
              return completion(returnModel, nil, responseData)
            
           } catch let error {
              print("Error creating current data from JSON because: \(error.localizedDescription)")
              return completion(nil, error, responseData)
           }
      }
    
}

