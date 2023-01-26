//
//  ProductListResponseDTO.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

struct ProductListResponseDTO: Decodable {
    let pageNo, itemsPerPage, totalCount, offset: Int
    let limit, lastPage: Int
    let hasNext, hasPrev: Bool
    let pages: [Product]
}

extension ProductListResponseDTO {
    func toDomain() -> ProductListResponse {
        return ProductListResponse(
            pageNo: pageNo,
            itemsPerPage: itemsPerPage,
            totalCount: totalCount,
            offset: offset,
            limit: limit,
            lastPage: lastPage,
            hasNext: hasNext,
            hasPrev: hasPrev,
            pages: pages)
    }
}
