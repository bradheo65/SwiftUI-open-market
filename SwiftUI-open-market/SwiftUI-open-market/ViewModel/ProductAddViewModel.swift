//
//  ProductAddViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import Foundation
import UIKit
import Alamofire

class ProductAddViewModel {
    enum VendorInfo {
        static let accessId = "bread"
        static let name = "bread"
        static let identifier = "f67d572f-4aa2-11ed-a200-8ba6a006f5ab"
        static let secret = "z1xc3q4v12b3b1ja3ou"
    }
    
    func postProduct(image: [UIImage], item: [String: Any]) {
        let url = "https://openmarket.yagom-academy.kr/api/products"

        guard let jsonParams = try? JSONSerialization.data(withJSONObject: item, options: .prettyPrinted) else {
            return
        }
        
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: URL(string: url)!)
        
        request.addValue(VendorInfo.identifier, forHTTPHeaderField: "identifier")
        request.addValue("multipart/form-data;boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        
        let jsonbody = createJsonBody(paramaeters: ["params": jsonParams], boundary: boundary)
        let imageBody = createImageBody(images: image, boundary: boundary)
                    
        request.httpBody = jsonbody + imageBody
        
//        AF.request(request).responseString { (response) in
//            switch response.result {
//            case .success:
//                print(response)
//                print("POST 성공")
//            case .failure(let error):
//                print( rror)
//            }
//        }

        print("result", String(data: request.httpBody!, encoding: .utf8)!)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("data",String(describing: error))
                return
            }
            print("result", String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    private func createJsonBody(paramaeters: [String: Any], boundary: String) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in paramaeters {
            body.append(boundaryPrefix.data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n".data(using: .utf8)!)
            body.append("\r\n".data(using: .utf8)!)
            body.append("\(String(data: value as! Data, encoding: .utf8) ?? "")\r\n".data(using: .utf8)!)
        }
        return body
    }

    private func createImageBody(images: [UIImage]?, boundary: String) -> Data {
        var body = Data()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        if let images = images {
            for image in images {
                let imageData = image
                
                let imageData2: Data = imageData.jpegData(compressionQuality: 0.05) ?? Data()
                let imageStr: String = imageData2.base64EncodedString()
                
                let imageFile = ImageFile(key: "images",
                                          src: (imageStr.data(using: .utf8)!),
                                          type: "file")
                
                body.append(boundaryPrefix.data(using: .utf8)!)
                body.append("Content-Disposition: form-data; name=\"\(imageFile.key)\"; filename=\"\(arc4random())\".png\r\n\r\n".data(using: .utf8)!)
                body.append(imageFile.src)
                body.append("\r\n\r\n".data(using: .utf8)!)
            }
        }
        body.append("--\(boundary)--".data(using: .utf8)!)
        
        return body
    }
}
