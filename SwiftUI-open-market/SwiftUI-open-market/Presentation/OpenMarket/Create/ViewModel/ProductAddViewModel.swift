//
//  ProductAddViewModel.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import Foundation
import SwiftUI

final class ProductAddViewModel: ObservableObject {
    
    private let postMarketProductUseCase = PostMarketProductUseCase()
    private let patchMarketProductUseCase = PatchMarketProductUseCase()

    @Published var imageArray: [UIImage] = []
    @Published var detailImageArray: [DetailImage] = []
    @Published var title: String = ""
    @Published var currency = Currency.KRW
    @Published var price: String = "" {
        didSet {
            let filter = price.filter { $0.isNumber }
            if price != filter {
                price = filter
            }
        }
    }
    @Published var discountedPrice: String = "" {
        didSet {
            let filter = discountedPrice.filter { $0.isNumber }
            if discountedPrice != filter {
                discountedPrice = filter
            }
        }
    }
    @Published var stock: String = "" {
        didSet {
            let filter = stock.filter { $0.isNumber }
            if stock != filter {
                stock = filter
            }
        }
    }
    @Published var description: String = ""
    
    @Published var isPostSuccess: Bool = false
    @Published var isPostFail: Bool = false
    @Published var isPatchSuccess: Bool = false
    @Published var isPatchFail: Bool = false
    
    func fetch(item: DetailProduct) {
        detailImageArray = item.images
        title = item.name
        price = item.price.removeDecimal
        currency = Currency(rawValue: item.currency)!
        discountedPrice = item.discountedPrice.removeDecimal
        stock = item.stock.removeDecimal
        description = item.welcomeDescription
    }
    
    func requestPostProductItem() {
        let productInfo = ProductInfo(
            name: title,
            description: description,
            price: Int(price) ?? 0,
            currency: currency.rawValue,
            discountedPrice: Int(discountedPrice) ?? 0,
            stock: Int(stock) ?? 0,
            secret: VendorInfo.secret
        )
        
        guard let value = try? JSONEncoder().encode(productInfo) else {
            return
        }
        
        postMarketProductUseCase.excute(images: imageArray, parameters: value) { result in
            switch result {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.isPostSuccess = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isPostFail = true
                }
            }
        }
    }
    
    func patch(id: Int) {
        
        let patchProductInfo = PatchProductInfo(
            stock: Int(stock) ?? 0,
            productID: id,
            name: title,
            description: description,
            discountedPrice: Int(discountedPrice) ?? 0,
            price: Int(price) ?? 0,
            currency: currency.rawValue,
            secret: VendorInfo.secret
        )
        
        guard let value = try? JSONEncoder().encode(patchProductInfo) else {
            return
        }
        
        patchMarketProductUseCase.excute(id: id, parameters: value) { result in
            switch result {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    self.isPatchSuccess = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    self.isPatchFail = true
                }
            }
        }
    }
    
}
