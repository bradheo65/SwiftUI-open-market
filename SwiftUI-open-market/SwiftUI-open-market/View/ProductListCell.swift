//
//  ProductListCell.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/12/10.
//

import SwiftUI

struct ProductListCell: View {
    let data: Product
    
    private let productListCellModel = ProductCellModel()
    
    var body: some View {
        HStack {
            CacheAsyncImage(url: productListCellModel.getURL(Product: data)) {
                    phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                    case .empty:
                        ProgressView()
                    case .failure(_):
                        Image(systemName: "photo")
                    @unknown default:
                        Image(systemName: "photo")
                    }
                }
                .frame(width: 60, height: 60)
            
            VStack {
                HStack {
                    Text(productListCellModel.getName(Product: data))
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                        .font(.title3)
                        .lineLimit(1)
                    if data.stock != 0 {
                        HStack {
                            Text("잔여수량:")
                            Text(productListCellModel.getStock(Product: data))
                        }
                        .frame(alignment: .trailing)
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    } else {
                        Text("품절")
                            .frame(alignment: .trailing)
                            .foregroundColor(.yellow)
                    }
                }
                HStack {
                    if data.discountedPrice != 0 {
                        HStack {
                            HStack {
                                Text(productListCellModel.getCurrency(Product: data))
                                Text(productListCellModel.getPrice(Product: data))
                            }
                            .font(.system(size: 15))
                            .foregroundColor(.red)
                            .strikethrough()
                            
                            HStack {
                                Text(productListCellModel.getCurrency(Product: data))
                                Text(productListCellModel.getBargainPrice(Product: data))
                            }
                            .font(.system(size: 15))
                            .foregroundColor(.secondary)
                            .lineLimit(1)
                        }
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                    } else {
                        HStack {
                            Text(productListCellModel.getCurrency(Product: data))
                            Text(productListCellModel.getPrice(Product: data))
                        }
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .frame(maxWidth: .infinity,
                               alignment: .leading)
                    }
                }
            }
        }
    }
}
