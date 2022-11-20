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
    
    func postProduct(id: Int) {
        let url = "https://openmarket.yagom-academy.kr/api/products"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
        // POST 로 보낼 정보
        let params = ["id":"아이디", "pw":"패스워드"] as Dictionary
        
        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseString { (response) in
            switch response.result {
            case .success:
                print("POST 성공")
            case .failure(let error):
                print(error)
            }
        }
    }
}
