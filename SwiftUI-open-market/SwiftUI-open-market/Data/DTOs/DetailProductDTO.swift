//
//  DetailProductDTO.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

struct DetailProductDTO: Codable {
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

extension DetailProductDTO {
    func toDomain() -> DetailProduct {
        return DetailProduct(
            id: id,
            vendorID: vendorID,
            name: name,
            welcomeDescription: welcomeDescription,
            thumbnail: thumbnail,
            currency: currency,
            price: price,
            bargainPrice: bargainPrice,
            discountedPrice: discountedPrice,
            stock: stock,
            createdAt: createdAt,
            issuedAt: issuedAt,
            images: images,
            vendors: vendors
        )
    }
}
