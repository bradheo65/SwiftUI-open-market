//
//  ProductInfo.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/12/15.
//

import Foundation

struct ProductInfo: Codable {
    var name: String
    var description: String
    var price: Int
    var currency: String
    var discountedPrice: Int
    var stock: Int
    var secret: String
    
    enum CodingKeys: String, CodingKey {
        case name, description, currency
        case price, stock
        case secret
        case discountedPrice = "discounted_price"
    }
}
