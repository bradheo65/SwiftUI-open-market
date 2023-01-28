//
//  PostMarketProductUseCase.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/28.
//

import Foundation
import UIKit

final class PostMarketProductUseCase {
    
    private let repository: MarketProductPostRepositoryInterface
    
    init(repository: MarketProductPostRepositoryInterface = MarketProductPostRepository()) {
        self.repository = repository
    }
    
    func excute(images: [UIImage], parameters: Data, completion: @escaping (Result<DetailProduct, Error>) -> Void) {
        repository.postProduct(images: images, parameters: parameters) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
