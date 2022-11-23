//
//  ProductDetailView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/19.
//

import SwiftUI

struct ProductDetailView: View {
    
    @ObservedObject private var productDetailViewModel = ProductDetailViewModel()
    var item: Int = 0
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<(productDetailViewModel.item?.images.count ?? 0), id: \.self) { images in
                        AsyncImage(url: URL(string: productDetailViewModel.item?.images[images].url ?? "")) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                            case .failure:
                                EmptyView()
                            @unknown default:
                                Image(systemName: "photo")
                            }
                        }
                        .frame(width: 350, height:350)
                        .aspectRatio(contentMode: .fit)
                    }
                    .padding()
                }
            }
            Text("\(productDetailViewModel.item?.images.count ?? 0) / 5 ")
                .foregroundColor(.secondary)

            HStack {
                Text("\(productDetailViewModel.item?.name ?? "name")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(productDetailViewModel.item?.stock ?? 0)")
                    .frame(alignment: .trailing)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .trailing) {
                if productDetailViewModel.item?.discountedPrice != 0 {
                    Text("\(productDetailViewModel.item?.currency ?? "") \(Int((productDetailViewModel.item?.price ?? 0)))")
                        .font(.system(size: 15))
                        .foregroundColor(.red)
                        .strikethrough()
                    
                    Text("\(productDetailViewModel.item?.currency ?? "") \(Int((productDetailViewModel.item?.bargainPrice ?? 0)))")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                } else {
                    Text("\(productDetailViewModel.item?.currency ?? "") \(Int((productDetailViewModel.item?.price ?? 0)))")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text("\(productDetailViewModel.item?.welcomeDescription ?? "welcomeDescription")")
                .frame(maxWidth: .infinity, maxHeight: 600, alignment: .topLeading)
        }
        .task {
            productDetailViewModel.getProduct(id: item)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(productDetailViewModel.item?.name ?? "")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView()
    }
}
