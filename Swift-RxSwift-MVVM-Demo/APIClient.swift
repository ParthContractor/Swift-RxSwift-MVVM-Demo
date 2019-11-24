//
//  APIClient.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation

class APIClient {
    static func requestData<T: Codable>(responseObjeType: T.Type, apiRequest: URLRequest, completionHandler: @escaping (_ result:T?,_ error:Error?) -> Void) {

        URLSession.shared.dataTask(with: apiRequest) { (data, response, error) in
                    if error != nil {
                        completionHandler(nil,error)
                    }
        
                    guard let jsonData = data else { return }
        
                    //JSONDecoder for decoding/parsing data to our custom models having foundation objects/nested structs using decodable protocol
                    let decoder = JSONDecoder()
        
                    do {
                        let result = try decoder.decode(responseObjeType, from: jsonData)
                        //instance of T to be returned after successful decoding process..
                        completionHandler(result,nil)
                    } catch let jsonErr {
                        //error to be returned in case of failure in decoding..
                        completionHandler(nil,jsonErr)
                    }
        
        }.resume()
        }
}
