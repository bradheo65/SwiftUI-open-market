//
//  Product-istResponse.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

struct ProductListResponse: Codable {
    let pageNo, itemsPerPage, totalCount, offset: Int
    let limit, lastPage: Int
    let hasNext, hasPrev: Bool
    let pages: [Product]
}
