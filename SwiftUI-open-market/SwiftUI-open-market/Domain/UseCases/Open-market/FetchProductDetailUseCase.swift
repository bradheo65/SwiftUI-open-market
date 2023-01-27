//
//  FetchProductDetailUseCase.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

final class FetchProductDetailUseCase {
    
    private let repository: MarketProductDetailRepositoryInterface
    
    init(repository: MarketProductDetailRepositoryInterface = MarketProductDetailRepository()) {
        self.repository = repository
    }
    
    func excute(id: Int, completion: @escaping (Result<DetailProduct, Error>) -> Void) {
        repository.fetchDetailProduct(id: id) { result in
            switch result {
            case .success(let detailProduct):
                completion(.success(detailProduct))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
