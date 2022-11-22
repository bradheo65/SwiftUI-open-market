//
//  ProductDetailViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/19.
//

import Foundation

class ProductDetailViewModel: ObservableObject {
    
    lazy var productAPI = ProductAPI()
    @Published var item: DetailProduct?
    
    func getProduct(id: Int) {
        productAPI.getProductDetail(id: id) { isSuccess, model in
            switch isSuccess {
            case true:
                self.item = model
            case false:
                print("error")
            }
        }
    }
}
