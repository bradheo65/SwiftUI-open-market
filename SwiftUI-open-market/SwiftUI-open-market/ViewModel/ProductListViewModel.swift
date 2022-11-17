//
//  ProductListViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import Foundation

class ProductListViewModel: ObservableObject {
    
    lazy var productAPI = ProductAPI()
    @Published var lists = [Product]()
    
//    init() {
//        getProduct(page: 1, size: 10)
//    }
    
    func getProduct(page: Int, size: Int) {
        
        productAPI.getProduct(page: page, size: size) { isSuccess, model in
            switch isSuccess {
            case true:
                self.lists = model?.pages ?? []
                print(self.lists[0])

            case false:
                print("error")
            }
        }
    }
}
