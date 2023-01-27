//
//  ProductDetailViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/19.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    
    private let fetchProductDetailUseCase = FetchProductDetailUseCase()
    private let deleteProductUseCase = DeleteProductUseCase()
    
    @Published var item: DetailProduct?
    @Published var isDeleteSuccess: Bool = false
    @Published var isDeleteFail: Bool = false

    func fetchDetailProduct(id: Int) {
        fetchProductDetailUseCase.excute(id: id) { result in
            switch result {
            case .success(let detailProduct):
                DispatchQueue.main.async {
                    self.item = detailProduct
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func requestDeleteProduct(id: Int) {
        let parameters =
        [
            "secret": VendorInfo.secret
        ] as [String : Any]
        
        deleteProductUseCase.excute(id: id, parmeters: parameters) { result in
            switch result {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.isDeleteSuccess = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isDeleteFail = true
                }
            }
        }
    }
    
    func getCount() -> Int {
        let count = item?.images.count ?? 0
        return count
    }
    
    func getID() -> Int {
        let id = item?.id ?? 0
        return id
    }
    
    func getImageURL(index: Int) -> String {
        let imageURL = item?.images[index].url ?? ""
        return imageURL
    }
    
    func getName() -> String {
        let name = item?.name ?? ""
        return name
    }

    func getCurrency() -> String {
        let currency = item?.currency ?? ""
        return currency
    }
    
    func getPrice() -> String {
        let price = item?.price.removeDecimal ?? ""
        let priceComma = price.insertComma
        
        return priceComma
    }
    
    func getBargainPrice() -> String {
        let bargainPrice = item?.bargainPrice.description ?? ""
        let bargainPriceComma = bargainPrice.insertComma
        
        return bargainPriceComma
    }
    
    func getStock() -> String {
        let stock = item?.stock.removeDecimal ?? ""
        let stockComma = stock.insertComma
        
        return stockComma
    }
    
    func getWelcomeDescription() -> String {
        let welcomeDescription = item?.welcomeDescription ?? ""
        return welcomeDescription
    }
}
