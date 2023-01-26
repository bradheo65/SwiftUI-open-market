//
//  ProductListViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import Foundation

final class ProductListViewModel: ObservableObject {
    
    @Published var lists = [Product]()
    
    private let fetchMarketListUseCase = FetchMarketListUseCase()

    private var page = 1
    private var size = 20
    
    func fetchMarketProductList() {
        size += 5
        
        fetchMarketListUseCase.excute(page: page, size: size) { result in
            switch result {
            case .success(let productList):
                print(productList)
                
                DispatchQueue.main.async {
                    self.lists = productList.pages
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
