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
}
