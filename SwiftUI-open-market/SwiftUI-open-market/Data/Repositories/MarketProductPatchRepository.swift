//
//  MarketProductPatchRepository.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/28.
//

import Foundation
import UIKit

final class MarketProductPatchRepository: MarketProductPatchRepositoryInterface {
    
    private let networkService = NetworkService.shared
    
    func patchProduct(id: Int, parameters: Data, completion: @escaping (Result<DetailProduct, Error>) -> Void) {
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        urlComponents?.path += "/"
        urlComponents?.path += "\(id)"
        
        guard let url = urlComponents?.url else {
            return
        }
                
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PATCH"

        urlRequest.setValue(VendorInfo.identifier, forHTTPHeaderField: "identifier")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let productBody = parameters

        urlRequest.httpBody = productBody
        
        let dataTask = networkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let detailProductDTO = try JSONDecoder().decode(DetailProductDTO.self, from: data)
                    let responseData = detailProductDTO.toDomain()
                    completion(.success(responseData))
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
