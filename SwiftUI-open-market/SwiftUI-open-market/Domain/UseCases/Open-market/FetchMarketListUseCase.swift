//
//  FetchMarketListUseCase.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

final class FetchMarketListUseCase {
    
    private let repository: MarketProductListRepositoryInterface
    
    init(repository: MarketProductListRepositoryInterface = MarketProductListRepository()) {
        self.repository = repository
    }
    
    func excute(page: Int, size: Int, completion: @escaping (Result<ProductListResponse, Error>) -> Void) {
        repository.fetchMarketList(page: page, size: size) { result in
            switch result {
            case .success(let marketList):
                completion(.success(marketList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
