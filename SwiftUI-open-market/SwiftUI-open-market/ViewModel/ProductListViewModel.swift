//
//  ProductListViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    
    @Published var lists = [Product]()
    let isFull = false
    
    private lazy var productAPI = ProductAPI()

    private var page = 1
    private var size = 20
    
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
