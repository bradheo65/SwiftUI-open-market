//
//  MarketProductListRepositoryInterface.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

protocol MarketProductListRepositoryInterface {
    
    func fetchMarketList(page: Int, size: Int, completion: @escaping (Result<ProductListResponse, Error>) -> Void)
    
}
