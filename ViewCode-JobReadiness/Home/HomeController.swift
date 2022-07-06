//
//  HomeController.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 04/07/22.
//

import Foundation

class HomeController {
    private let api = MeliApiService()
    private var topCategory : TopCategory?
    var productList : ProductList?
    
    var productCount: Int {
        return productList?.count ?? 0
    }
    
    
    
    func getProducts(product : String, completion: @escaping () -> Void) {
        api.predictCategory(product: product) { result in
            self.api.getTopProducts(categoryID: result.categoryID) { result in
                self.topCategory = result
                self.api.getItemListInfo(idList: result.content) { result in
                    self.productList = result
                    print(result)
                    completion()
                    self.debugProducts()
                    
                    print("eita")
                }
            }
        }
    }
    
    func selectProduct(index : Int) -> Product? {
        
        guard let productList = productList else {
            return nil
        }
        
        return productList[index]
    }
    
    

    
    func debugProducts(){
        guard let prodList = productList else {
            return
        }
        for product in prodList {
            print(product.body.id + "  \(product.body.price ?? -999999) \(product.body.title ?? "❌") ")
        }
        print(prodList.count)
        
    }
    
    
    
    

}
