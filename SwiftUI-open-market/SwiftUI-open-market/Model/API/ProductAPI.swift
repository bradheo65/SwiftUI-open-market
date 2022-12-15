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
    
    func getProduct(page: Int, size: Int, completion: @escaping (Bool, ProductListResponse?) -> Void) {
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)

        let pageNo = URLQueryItem(name: OpenMarketAPI.pageNo, value: "\(page)")
        let itemPerPage = URLQueryItem(name: OpenMarketAPI.itemsPerPage, value: "\(size)")

        urlComponents?.queryItems = [pageNo, itemPerPage]
        
        AF.request(urlComponents?.string ?? "",
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
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        urlComponents?.path += "/"
        urlComponents?.path += "\(id)"
                
        AF.request(urlComponents?.string ?? "",
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
    
    func requestDeleteProductURL(id: Int, parameters: [String : Any], completion: @escaping (Result<Data, Error>) -> Void) {
        
        var urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        urlComponents?.path += "/"
        urlComponents?.path += "\(id)"
        urlComponents?.path += "/"
        urlComponents?.path += "\(OpenMarketAPI.deletePath)"
        
        let header: HTTPHeaders = [
            "identifier": VendorInfo.identifier
        ]

        AF.request(urlComponents?.string ?? "",
                   method: .post,
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
    
    func deleteProduct(deleteURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        let urlComponents = URLComponents(string: OpenMarketAPI.url + deleteURL)
        
        let header: HTTPHeaders = [
            "identifier": VendorInfo.identifier
        ]

        AF.request(urlComponents?.string ?? "",
                   method: .delete,
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
