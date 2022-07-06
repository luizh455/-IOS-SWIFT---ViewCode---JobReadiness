//
//  MeliApiSerice.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 04/07/22.
//

import Foundation
import Alamofire


class MeliApiService {
    var alamofireAPIClient = AlamofireAPIClient()
    private var predictBaseUrl = "https://api.mercadolibre.com/sites/MLB/domain_discovery/search?limit=1&q="
    private var topProductsBaseUrl = "https://api.mercadolibre.com/highlights/MLB/category/"
    private var multiGetBaseURL = "https://api.mercadolibre.com/items?ids="
    
    
    func getAuthHeader() -> HTTPHeaders{
        let headers: HTTPHeaders = [
            .authorization(bearerToken: "APP_USR-4360983207824602-070610-06fdafe5f34f4d3267bf8af8505dd97a-136470154"),
            .accept("application/json")
        ]
        return headers
    }
    
    func predictCategory(product : String, onError : @escaping () -> Void, completion: @escaping (PredictedCategory) -> Void){
        var customProduct = product
        customProduct = product.replacingOccurrences(of: " ", with: "+")
        alamofireAPIClient.get(url: predictBaseUrl+customProduct, customHeader: getAuthHeader()) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data {
                        let predictedCategory = try
                        JSONDecoder().decode(predictedCategoryElement.self, from: data)
                        if(predictedCategory.isEmpty)
                        {
                            onError()
                            print("error predict")
                            
                        }
                        else {
                            completion(predictedCategory[0])
                            
                        }
                    }
                }
                catch
                {
                    onError()
                    print("catch predict \(error)")
                }
                
            case .failure:
                print("failure predict")
                onError()
            }
        }
        
    }
    
    func getTopProducts(categoryID : String, completion: @escaping (TopCategory) -> Void){
        alamofireAPIClient.get(url: topProductsBaseUrl+categoryID, customHeader: getAuthHeader()) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data {
                        let topCategoryList = try
                        JSONDecoder().decode(TopCategory.self, from: data)
                        completion(self.itemFilter(topCategoryList: topCategoryList))
                    }
                }catch {
                    print("catch topProducts \(error)")
                }
            case .failure:
                print("failure get top products")
            }
        }
    }
    
    func itemFilter(topCategoryList : TopCategory) -> TopCategory{
        let auxCat = TopCategory(queryData: topCategoryList.queryData,
                                 content: topCategoryList.content.filter({ item in
            item.type == "ITEM"
        }))
        
        return auxCat
        
    }
    
    func getItemListInfo(idList : [Content], completion: @escaping (ProductList) -> Void){
        
        var productsURL = multiGetBaseURL;
        
        for id in idList{
            productsURL += "\(id.id),"
        }
        
        alamofireAPIClient.get(url: productsURL, customHeader: getAuthHeader()) { result in
            switch result {
            case .success(let data):
                do {
                    if let data = data {
                        let productList = try
                        JSONDecoder().decode(ProductList.self, from: data)
                        completion(productList)
                    }
                }catch {
                    print("catch productList \(error)")
                }
            case .failure:
                print("failure get product list")
            }
        }
    }
    
}
