//
//  PatchMarketProductUseCase.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/28.
//

import Foundation

final class PatchMarketProductUseCase {
    
    private let repository: MarketProductPatchRepositoryInterface
    
    init(repository: MarketProductPatchRepositoryInterface = MarketProductPatchRepository()) {
        self.repository = repository
    }
    
    func excute(id: Int, parameters: Data, completion: @escaping (Result<DetailProduct, Error>) -> Void) {
        repository.patchProduct(id: id, parameters: parameters) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
