//
//  PatchProductInfo.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/28.
//

import Foundation

struct PatchProductInfo: Codable {
    let stock, productID: Int
    let name, description: String
    let discountedPrice, price: Int
    let currency, secret: String

    enum CodingKeys: String, CodingKey {
        case stock
        case productID = "product_id"
        case name, description
        case discountedPrice = "discounted_price"
        case price, currency, secret
    }
}
