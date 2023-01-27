//
//  MarketProductDetailRepositoryInterface.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/26.
//

import Foundation

protocol MarketProductDetailRepositoryInterface {

    func fetchDetailProduct(id: Int, completion: @escaping (Result<DetailProduct, Error>) -> Void)
    
}
