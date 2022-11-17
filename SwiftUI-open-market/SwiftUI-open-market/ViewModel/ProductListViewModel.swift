//
//  ProductListViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import Foundation

class ProductListViewModel {
    
    lazy var productAPI = ProductAPI()
    var lists: [Product] = []
    
    init() {
        getProduct(page: 1, size: 10)
    }
    
    func getProduct(page: Int, size: Int) {
        
        productAPI.getProduct(page: page, size: size) { isSuccess, model in
            switch isSuccess {
            case true:
                self.lists = model?.pages ?? []
                print(self.lists)

            case false:
                print("error")
            }
        }
    }
}
