//
//  ProductAPI.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import Alamofire

final class ProductAPI {
    
    private enum OpenMarketAPI {
        static let url = "https://openmarket.yagom-academy.kr"
        static let products = "/api/products"
        static let pageNo = "page_no"
        static let itemsPerPage = "items_per_page"
        static let deletePath = "archived"
    }

    func postProduct(images: [UIImage], parameters: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        let header: HTTPHeaders = [
            "identifier": VendorInfo.identifier,
            "Content-Type": "multipart/form-data"
        ]
        
        AF.upload(multipartFormData: { multipartFormData in

            multipartFormData.append("\(parameters)".data(using: .utf8)!, withName: "params", mimeType: "application/json")
              
            for image in images {
                let imageData: Data = image.jpegData(compressionQuality: 0.1)!

                multipartFormData.append(imageData, withName: "images", fileName: "\(imageData).jpg", mimeType: "content-type header")
            }
        
        }, to: urlComponents?.string ?? "",
                  method: .post,
                  headers: header)
        .responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func patchProduct(id: Int, images: [UIImage], parameters: [String : Any], completion: @escaping (Result<Data, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        urlComponents?.path += "/"
        urlComponents?.path += "\(id)"
        
        let header: HTTPHeaders = [
            "identifier": VendorInfo.identifier
        ]

        AF.request(urlComponents?.string ?? "",
                   method: .patch,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: header)
        .responseData { response in
            switch response.result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                print(error)
            }
        }
    }
}
