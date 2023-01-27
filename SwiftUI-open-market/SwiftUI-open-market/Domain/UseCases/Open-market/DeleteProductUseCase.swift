//
//  DeleteProductUseCase.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

final class DeleteProductUseCase {
    
    private let repository: MarketProductDeleteRepositoryInterface
    
    init(repository: MarketProductDeleteRepositoryInterface = MarketProductDeleteRepository()) {
        self.repository = repository
    }
    
    func excute(id: Int, parmeters: [String: Any], completion: @escaping (Result<Data, Error>) -> Void) {
        repository.requestDeleteProductURL(id: id, parameters: parmeters) { result in
            switch result {
            case .success(let data):
                let selecteURL = String(data: data, encoding: .utf8) ?? ""
                let parsingURL = selecteURL.trimmingCharacters(in: ["="])
                
                self.repository.deleteProduct(deleteURL: parsingURL) { result in
                    switch result {
                    case .success(let data):
                        completion(.success(data))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
