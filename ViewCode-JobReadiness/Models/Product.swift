//
//  Product.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 04/07/22.
//

import Foundation


struct Seller: Codable {
    struct City : Codable{
        let name : String?
        
    }
    let city : City?
    
}

struct Picture : Codable {
    let url : String
}

struct Body: Codable {

    let id : String
    let price : Float?
    let title : String?
    let pictures : [Picture?]
    //let seller_address : [Seller?]
    
}

struct Product : Codable {
    let body : Body
    let code : Int
    
}
typealias ProductList = [Product]
