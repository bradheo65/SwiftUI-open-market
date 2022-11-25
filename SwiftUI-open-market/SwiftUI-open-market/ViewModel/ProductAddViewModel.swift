//
//  ProductAddViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import Foundation
import SwiftUI

class ProductAddViewModel: ObservableObject {
    
    let productAPI = ProductAPI()
    
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
            case .failure(let error):
                print(error)
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
                print(String(data: data, encoding: .utf8)!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func resizeImage(image: UIImage, height: CGFloat) -> UIImage {
        let scale = height / image.size.height
        let width = image.size.width * scale
        
        UIGraphicsBeginImageContext(CGSize(width: width, height: height))
        image.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        return newImage!
    }
}
