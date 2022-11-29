//
//  DetailImage.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/28.
//

struct DetailImage: Codable {
    let id: Int
    let url, thumbnailURL: String
    let issuedAt: String

    enum CodingKeys: String, CodingKey {
        case id, url
        case thumbnailURL = "thumbnail_url"
        case issuedAt = "issued_at"
    }
}
