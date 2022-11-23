//
//  ProductAPI.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import Foundation
import Alamofire

class ProductAPI {
    
    func getProduct(page: Int, size: Int, completion: @escaping (Bool, ProductListResponse?) -> Void) {
        let URL = "https://openmarket.yagom-academy.kr/api/products?page_no=\(page)&items_per_page=\(size)"
        
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json"])
        .responseDecodable(of: ProductListResponse.self) { response in
            switch response.result {
            case .success(let response):
                completion(true, response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getProductDetail(id: Int, completion: @escaping (Bool, DetailProduct?) -> Void) {
        let URL = "https://openmarket.yagom-academy.kr/api/products/\(id)"
        
        AF.request(URL,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json"])
        .responseDecodable(of: DetailProduct.self) { response in
            switch response.result {
            case .success(let response):
                completion(true, response)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func postProduct(images: [UIImage], parameters: [String : Any], completion: @escaping (Result<Data, Error>) -> Void) {
        
        let url = "https://openmarket.yagom-academy.kr/api/products"
        let header: HTTPHeaders = [
            "identifier": VendorInfo.identifier,
            "Content-Type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in parameters {
                if key == "value" {
                    multipartFormData.append("\(value)".data(using: .utf8)!, withName: "params", mimeType: "application/json")
                }
            }
            
            for image in images {
                let imageData: Data = image.jpegData(compressionQuality: 0.8)!
                
                multipartFormData.append(imageData, withName: "images", fileName: "\(imageData).jpg", mimeType: "content-type header")
            }
        
        }, to: url, method: .post, headers: header).response { response in
            guard let statusCode = response.response?.statusCode else {
                return
            }
            
            switch statusCode {
            case 200:
                completion(.success(response.data ?? Data()))
            default:
                completion(.success(response.data ?? Data()))
            }
        }
    }
}
