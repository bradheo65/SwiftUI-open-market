//
//  ProductAddViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import Foundation
import SwiftUI

final class ProductAddViewModel: ObservableObject {
    
    private let productAPI = ProductAPI()
    
    @Published var isPostSuccess: Bool = false
    @Published var isPostFail: Bool = false
    @Published var isPatchSuccess: Bool = false
    @Published var isPatchFail: Bool = false

    func post(image: [UIImage], name: String, descriptions: String, price: Int, currency: String, discountPrice: Int, stock: Int) {
        let parameters =
        [
            "key": "params",
            "value": "{ \"name\": \"\(name)\", \"description\": \"\(descriptions)\", \"price\": \(price), \"currency\": \"\(currency)\", \"discounted_price\": \(discountPrice), \"stock\": \(stock), \"secret\": \"\(VendorInfo.secret)\" }",
            "type": "text",
            "contentType": "application/json"
        ] as [String : Any]
        
        productAPI.postProduct(images: image, parameters: parameters) { response in
            switch response {
            case .success(let data):
                print(data)
                self.isPostSuccess = true
            case .failure(let error):
                print(error)
                self.isPostFail = true
            }
        }
    }
    
    func patch(id: Int, image: [UIImage], name: String, descriptions: String, price: Int, currency: String, discountPrice: Int, stock: Int) {
        
        let parameters =
        [
            "identifier": VendorInfo.identifier,
            "product_id": id,
            "name": name,
            "description": descriptions,
            "price": price,
            "currency": currency,
            "discounted_price": discountPrice,
            "stock": stock,
            "secret": VendorInfo.secret
        ] as [String : Any]
        
        productAPI.patchProduct(id: id, images: image, parameters: parameters) { response in
            switch response {
            case .success(let data):
                print(data)
                self.isPatchSuccess = true
            case .failure(let error):
                print(error)
                self.isPatchFail = true
            }
        }
    }
}
