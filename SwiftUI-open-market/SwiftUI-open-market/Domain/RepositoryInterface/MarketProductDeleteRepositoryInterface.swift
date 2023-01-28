//
//  MarketProductDeleteRepositoryInterface.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

protocol MarketProductDeleteRepositoryInterface {
    
    func requestDeleteProductURL(id: Int, parameters: Data, completion: @escaping (Result<Data, Error>) -> Void)
    
    func deleteProduct(deleteURL: String, completion: @escaping (Result<Data, Error>) -> Void)
    
}
