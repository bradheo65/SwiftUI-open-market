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
                        .aspectRatio(contentMode: .fill)
                    }
                    .padding()
                }
            }
            
            HStack {
                Text("\(productDetailViewModel.item?.name ?? "name")")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(productDetailViewModel.item?.stock ?? 0)")
                    .frame(alignment: .trailing)
            }
            
            VStack(alignment: .trailing) {
                Text("\(productDetailViewModel.item?.bargainPrice ?? 0)")
                
                Text("\(productDetailViewModel.item?.discountedPrice ?? 0)")
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
