//
//  DetailProduct.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/19.
//

struct DetailProduct: Codable {
    let id, vendorID: Int
    let name, welcomeDescription: String
    let thumbnail: String
    let currency: String
    let price, bargainPrice, discountedPrice, stock: Double
    let createdAt, issuedAt: String
    let images: [DetailImage]
    let vendors: Vendors

    enum CodingKeys: String, CodingKey {
        case id
        case vendorID = "vendor_id"
        case name
        case welcomeDescription = "description"
        case thumbnail, currency, price
        case bargainPrice = "bargain_price"
        case discountedPrice = "discounted_price"
        case stock
        case createdAt = "created_at"
        case issuedAt = "issued_at"
        case images, vendors
    }
}
