//
//  MarketProductPostRepository.swift
//  SwiftUI-open-market
//
//  Created by brad on 2023/01/27.
//

import Foundation
import UIKit

struct ImageFile {
    let key: String
    let src: Data
    let type: String
}

final class MarketProductPostRepository: MarketProductPostRepositoryInterface {
    
    private let networkService = NetworkService.shared
    
    func postProduct(images: [UIImage], parameters: Data, completion: @escaping (Result<DetailProduct, Error>) -> Void) {
        
        let urlComponents = URLComponents(string: OpenMarketAPI.url + OpenMarketAPI.products)
        
        guard let url = urlComponents?.url else {
            return
        }
        
        let boundary = "\(UUID().uuidString)"
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        urlRequest.setValue(VendorInfo.identifier, forHTTPHeaderField: "identifier")
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let productBody = createProductBody(paramaeters: parameters, boundary: boundary)
        let imageBody = createImageBody(images: images, boundary: boundary)
        
        urlRequest.httpBody = productBody + imageBody
        
        let dataTask = networkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let detailProductDTO = try JSONDecoder().decode(DetailProductDTO.self, from: data)
                    let responseData = detailProductDTO.toDomain()
                    completion(.success(responseData))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        dataTask?.resume()
    }
    
    private func createProductBody(paramaeters: Data, boundary: String) -> Data {
        var body = Data()
        let boundaryPrefix = "\r\n--\(boundary)\r\n"
        
        body.append(boundaryPrefix.data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"params\"\r\n".data(using: .utf8)!)
        body.append("\r\n".data(using: .utf8)!)
        body.append(paramaeters)
        body.append("\r\n".data(using: .utf8)!)

        return body
    }
    
    private func createImageBody(images: [UIImage], boundary: String) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for image in images {
            let imageData = image
            let imageFile = ImageFile(key: "images",
                                      src: (imageData.jpegData(compressionQuality: 0.1)!),
                                      type: "file")
            
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(imageFile.key)\"; filename=\"\(arc4random()).png\"\r\n".data(using: .utf8)!)
            body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
            body.append(imageFile.src)
            body.append("\r\n".data(using: .utf8)!)
        }
        
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--".data(using: .utf8)!)
        
        return body
    }
    
}

