//
//  AlamofireAPIClient.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 04/07/22.
//

import Foundation
import Alamofire

final class AlamofireAPIClient {
    func get(url: String, customHeader : HTTPHeaders?, completion: @escaping (Result<Data?, AFError>) -> Void) {
      
        AF.request(url, method: .get, parameters: .none, encoding: URLEncoding.default, headers: customHeader ?? .default, interceptor: .none, requestModifier: .none).response {
            response in
            print(response)
            completion(response.result)
        }
    }
}

