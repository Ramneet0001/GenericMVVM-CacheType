//
//  PersonViewModel.swift
//  genericModelMVVM
//
//  Created by Ramneet on 01/06/20.
//  Copyright © 2020 abc. All rights reserved.
//

import UIKit

class PersonViewModel {
    
    let apiManager = ApiManager()
    
    let cache = Shared.dataCache
    
    func getUserDetail(view:UIViewController, listIndex: Int, completion: @escaping (_ returnModel: PersonListModel?, _ returnError: Error?) -> Void ) {
        
        cache.fetch(key:self.getApiIndex(index: listIndex))
        .onSuccess({ (data) in
            
            LoaderClass().startLoader(message: "Getting Cache...", controller: view)
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                if let returnModel = try? decoder.decode(PersonListModel.self, from: data){
                    return completion(returnModel, nil)
                }}
                })
            
        .onFailure { (error) in
            
             LoaderClass().startLoader(message: "Calling Network...", controller: view)
            self.callNetwork(listIndex: listIndex) { (modelResponse, error, data)  in
                
                self.cache.set(value: data, key:self.getApiIndex(index: listIndex))
                return completion(modelResponse, nil)
            }
        }
    }
    
    
    func callNetwork(listIndex: Int, completion: @escaping (_ returnModel: PersonListModel?, _ returnError: Error?, _ data: Data) -> Void ){
        apiManager.callApiService(urlString: self.getApiIndex(index: listIndex), method: "GET", headers: [:], params: [:], typeModel: PersonListModel.self) { (modelResponse, error, data)  in
            
            if let error = error {
                print("Get error: \(error.localizedDescription)")
                return
            }
            guard let response = modelResponse  else { return }
            completion(response, error, data!)
        }
    }
    
    
    private func getApiIndex(index:Int)-> String{ // this is temporary Api array.
        
        let aray = ["http://www.mocky.io/v2/5ed55f8e330000fa13f7a9ea",
                    "http://www.mocky.io/v2/5ed561313300005f00f7a9f2",
                    "http://www.mocky.io/v2/5ed5694a3300000a2cf7aa18",
                    "http://www.mocky.io/v2/5ed55f8e330000fa13f7a9ea",
                    "http://www.mocky.io/v2/5ed561313300005f00f7a9f2",
                    "http://www.mocky.io/v2/5ed5694a3300000a2cf7aa18",
                    "http://www.mocky.io/v2/5ed55f8e330000fa13f7a9ea",
                    "http://www.mocky.io/v2/5ed561313300005f00f7a9f2",
                    "http://www.mocky.io/v2/5ed5694a3300000a2cf7aa18",
                    "http://www.mocky.io/v2/5ed6b338340000740006dbf2"]
      
        return aray[index]   }
        
}


