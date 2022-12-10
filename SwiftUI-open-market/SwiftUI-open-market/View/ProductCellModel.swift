//
//  ProductCellModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/12/10.
//

import Foundation

final class ProductCellModel {
    
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
        let price = Product.price.removeDecimal
        let priceComma = price.insertComma
        
        return priceComma
    }

    func getBargainPrice(Product: Product) -> String {
        let bargainPrice = Product.bargainPrice.removeDecimal
        let bargainPriceComma = bargainPrice.insertComma
        
        return bargainPriceComma
    }

    func getStock(Product: Product) -> String {
        let stock = Product.stock.removeDecimal
        let stockComma = stock.insertComma
        
        return stockComma
    }
    
}
