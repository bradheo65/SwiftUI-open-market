//
//  Product.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

struct Product: Codable, Equatable {
    let id, vendorID: Int
    let vendorName, name, pageDescription: String
    let thumbnail: String
    let currency: String
    let price, bargainPrice, discountedPrice, stock: Double
    let createdAt, issuedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case vendorID = "vendor_id"
        case vendorName, name
        case pageDescription = "description"
        case thumbnail, currency, price
        case bargainPrice = "bargain_price"
        case discountedPrice = "discounted_price"
        case stock
        case createdAt = "created_at"
        case issuedAt = "issued_at"
    }
}
