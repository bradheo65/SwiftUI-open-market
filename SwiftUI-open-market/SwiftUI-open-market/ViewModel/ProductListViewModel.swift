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
    
    func getName(Product: Product) -> String {
        return Product.name
    }
    
    func getURL(Product: Product) -> URL {
        let url = URL(string: Product.thumbnail)!
        return url
    }
    
    func getCurrency(Product: Product) -> String {
        return Product.currency
    }
    
    func getPrice(Product: Product) -> String {
        let price = String(format: "%.f", Product.price)
        return price
    }
    
    func getBargainPrice(Product: Product) -> String {
        let bargainPrice = String(format: "%.f", Product.bargainPrice)
        return bargainPrice
    }
    
    func getStock(Product: Product) -> String {
        let stock = String(format: "%.f", Product.stock)
        return stock
    }
}
