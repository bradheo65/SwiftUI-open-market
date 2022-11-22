//
//  ProductAddViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import Foundation
import Alamofire

class ProductAddViewModel {
    
    func postProduct(image: [UIImage], name: String, descriptions: String, price: Int, currency: String, discountPrice: Int, stock: Int, secret: String) {
        let url = "https://openmarket.yagom-academy.kr/api/products"
 
        let boundary = "Boundary-\(UUID().uuidString)"
        var request = URLRequest(url: URL(string: url)!)

        request.addValue(VendorInfo.identifier,
                         forHTTPHeaderField: "identifier")
        
        request.addValue("multipart/form-data; boundary=\(boundary)",
                         forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        let jsonbody = createJsonBody(name: name, descriptions: descriptions, price: price, currency: currency, discountPrice: discountPrice, stock: stock, secret: secret, boundary: boundary)
        let imageBody = createImageBody(images: image, boundary: boundary)
                    
        let postData = jsonbody.data(using: .utf8)! + imageBody

        request.httpBody = postData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("data",String(describing: error))
                return
            }
            print("result", String(data: data, encoding: .utf8)!)
        }
        task.resume()
    }
    
    private func createJsonBody(name: String, descriptions: String, price: Int, currency: String, discountPrice: Int, stock: Int, secret: String, boundary: String) -> String {
        var body = ""
        let boundaryPrefix = "--\(boundary)\r\n"
        let parameters = [
          [
            "key": "params",
            "value": "{ \"name\": \"\(name)\", \"description\": \"\(descriptions)\", \"price\": \(price), \"currency\": \"\(currency)\", \"discounted_price\": \(discountPrice), \"stock\": \(stock), \"secret\": \"z1xc3q4v12b3b1ja3ou\" }",
            "type": "text",
            "contentType": "application/json"
          ]] as [[String : Any]]
        
        for param in parameters {
            body.append(boundaryPrefix)
            body.append("Content-Disposition:form-data; name=\"\(param["key"]!)\"\r\n")
            body.append("Content-Type: \("application/json")\r\n")
            body.append("\r\n")

            let paramType = param["type"] as! String
            if paramType == "text" {
              let paramValue = param["value"] as! String
              body += "\(paramValue)\r\n"
            }
        }
         return body
    }

    private func createImageBody(images: [UIImage]?, boundary: String) -> Data {
        var body = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        if let images = images {
            for image in images {
                
                let imageData: Data = image.jpegData(compressionQuality: 0.1)!
                
                let imageFile = ImageFile(key: "images",
                                          src:  imageData,
                                          type: "content-type header")
                
                body.append(boundaryPrefix.data(using: .utf8)!)
                body.append("Content-Disposition:form-data; name=\"\(imageFile.key)\"; filename=\"\(arc4random()).jpg\"\r\n".data(using: .utf8)!)
                body.append("Content-Type: \"\(imageFile.type)\"\r\n\r\n".data(using: .utf8)!)
                body.append(imageFile.src)
            }
        }
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        return body
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


struct myProduct: Codable {
    let key: String
    let value: [test]
}

struct test: Codable {
    let name: String
    let descriptions: String
    let price: Int
    let currency: String
    let discounted_price: Int
    let stock: Int
    let secrt: String
}



