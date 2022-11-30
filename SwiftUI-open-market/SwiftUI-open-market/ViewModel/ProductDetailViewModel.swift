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
                        print(String(data: success, encoding: .utf8) ?? "")
                    case .failure(let failure):
                        print(failure)
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
        let price = String(format: "%.f", item?.price ?? 0)
        return price
    }
    
    func getBargainPrice() -> String {
        let bargainPrice = String(format: "%.f", item?.bargainPrice ?? 0)
        return bargainPrice
    }
    
    func getStock() -> String {
        let stock = String(format: "%.f", item?.stock ?? 0)
        return stock
    }
    
    func getWelcomeDescription() -> String {
        let welcomeDescription = item?.welcomeDescription ?? ""
        return welcomeDescription
    }
}
