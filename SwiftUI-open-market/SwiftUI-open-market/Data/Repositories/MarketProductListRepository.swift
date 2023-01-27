//
//  MarketProductListRepository.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

final class MarketProductListRepository: MarketProductListRepositoryInterface {

    private let networkService = NetworkService.shared
    
    func fetchMarketList(page: Int, size: Int, completion: @escaping (Result<ProductListResponse, Error>) -> Void) {
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)

        let pageNo = URLQueryItem(name: OpenMarketAPI.pageNo, value: "\(page)")
        let itemPerPage = URLQueryItem(name: OpenMarketAPI.itemsPerPage, value: "\(size)")

        urlComponents?.queryItems = [pageNo, itemPerPage]
        
        guard let url = urlComponents?.url else {
            return
        }

        let urlRequest = URLRequest(url: url)
        
        let dataTask = networkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let productListResponseDTO = try JSONDecoder().decode(ProductListResponseDTO.self, from: data)
                    let productListResponses = productListResponseDTO.toDomain()
                    completion(.success(productListResponses))
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
