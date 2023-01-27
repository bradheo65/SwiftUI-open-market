//
//  MarketProductDetailRepository.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

final class MarketProductDetailRepository: MarketProductDetailRepositoryInterface {
    
    private let networkService = NetworkService.shared
    
    func fetchDetailProduct(id: Int, completion: @escaping (Result<DetailProduct, Error>) -> Void) {
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        urlComponents?.path += "/"
        urlComponents?.path += "\(id)"
        
        guard let url = urlComponents?.url else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        let dataTask = networkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let detailProductDTO = try JSONDecoder().decode(DetailProductDTO.self, from: data)
                    let detailProduct = detailProductDTO.toDomain()
                    completion(.success(detailProduct))
                } catch {
                    completion(.failure(error))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}
