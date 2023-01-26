//
//  ProductDetailViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/19.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    
    private lazy var productAPI = ProductAPI()
    
    @Published var item: DetailProduct?
    @Published var isDeleteSuccess: Bool = false
    @Published var isDeleteFail: Bool = false

    func getProduct(id: Int) {
        productAPI.getProductDetail(id: id) { isSuccess, model in
            switch isSuccess {
            case true:
                self.item = model
            case false:
                print("error")
            }
        }
    }
    
    func deleteProduct(id: Int) {
        let parameters =
        [
            "secret": VendorInfo.secret
        ] as [String : Any]
        
        productAPI.requestDeleteProductURL(id: id, parameters: parameters) { response in
            switch response {
            case .success(let data):
                let selecteURL = String(data: data, encoding: .utf8) ?? ""
                let parsingURL = selecteURL.trimmingCharacters(in: ["="])

                self.productAPI.deleteProduct(deleteURL: parsingURL) { response in
                    switch response {
                    case .success(let success):
                        print(success)
                        self.isDeleteSuccess = true
                    case .failure(let failure):
                        print(failure)
                        self.isDeleteFail = true
                    }
                }
            case .failure(let error):
                print(error)
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
