//
//  MarketProductDeleteRepository.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

final class MarketProductDeleteRepository: MarketProductDeleteRepositoryInterface {
    
    private let networkService = NetworkService.shared
    
    func requestDeleteProductURL(id: Int, parameters: [String : Any], completion: @escaping (Result<Data, Error>) -> Void) {
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        let requestBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        urlComponents?.path += "/"
        urlComponents?.path += "\(id)"
        urlComponents?.path += "/"
        urlComponents?.path += "\(OpenMarketAPI.deletePath)"
                
        guard let url = urlComponents?.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)

        urlRequest.addValue(VendorInfo.identifier, forHTTPHeaderField: "identifier")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpMethod = "POST"
        urlRequest.httpBody = requestBody
        
        let dataTask = networkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
                print(data)
            case .failure(let error):
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    func deleteProduct(deleteURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlComponents = URLComponents(string: OpenMarketAPI.url + deleteURL)

        guard let url = urlComponents?.url else {
            return
        }
        
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = "DELETE"
        urlRequest.addValue(VendorInfo.identifier, forHTTPHeaderField: "identifier")

        let dataTask = networkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
}
