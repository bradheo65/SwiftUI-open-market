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
    let isFull = false
    var page = 1
    var size = 20
    
    func getProduct() {
        size += 5
        productAPI.getProduct(page: page, size: size) { isSuccess, model in
            switch isSuccess {
            case true:
                self.lists = model?.pages ?? []
                
            case false:
                print("error")
            }
        }
    }
}
