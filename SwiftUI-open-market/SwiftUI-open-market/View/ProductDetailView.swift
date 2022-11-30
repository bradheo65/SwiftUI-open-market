//
//  ProductDetailView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/19.
//

import SwiftUI

struct ProductDetailView: View {
    
    var item: Int = 0
    
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject private var productDetailViewModel = ProductDetailViewModel()
    
    @State private var showAlert = false
    @State private var tag: Int? = nil
    @State private var currentImage: Int = 0
    @State private var showDetailView = false
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack {
            TabView(selection: self.$currentImage) {
                ForEach(0..<(productDetailViewModel.getCount()), id: \.self) { images in
                    AsyncImage(url: URL(string: productDetailViewModel.getImageURL(index: images))) { phase in
                        
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                        case .failure:
                            Image(systemName: "photo")
                        @unknown default:
                            Image(systemName: "photo")
                        }
                    }
                    .scaledToFit()
                }
                .padding()
            }
            .tabViewStyle(PageTabViewStyle())
            .frame(height:350)
            
            Text("\(currentImage + 1) / \(productDetailViewModel.getCount())")
                .foregroundColor(.secondary)
            
            HStack {
                Text(productDetailViewModel.getName())
                    .frame(maxWidth: .infinity,
                           alignment: .leading)
                
                Text(productDetailViewModel.getStock())
                    .frame(alignment: .trailing)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .trailing) {
                if productDetailViewModel.item?.discountedPrice != 0 {
                    HStack {
                        Text(productDetailViewModel.getCurrency())
                        Text(productDetailViewModel.getPrice())
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.red)
                    .strikethrough()
                    
                    HStack {
                        Text(productDetailViewModel.getCurrency())
                        Text(productDetailViewModel.getBargainPrice())
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                } else {
                    HStack {
                        Text(productDetailViewModel.getCurrency())
                        Text(productDetailViewModel.getPrice())
                    }
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Text(productDetailViewModel.getWelcomeDescription())
                .frame(maxWidth: .infinity,
                       maxHeight: 600,
                       alignment: .topLeading)
        }
        .task {
            productDetailViewModel.getProduct(id: item)
        }
        .padding()
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(productDetailViewModel.getName())
        .toolbar {
            if productDetailViewModel.item?.vendorID == VendorInfo.venderID {
                Button {
                    showAlert = true
                } label: {
                    Image(systemName: "square.and.arrow.up")
                }
            }
        }
        .confirmationDialog("", isPresented: $showAlert) {
            VStack {
                Button {
                    showDetailView = true
                } label: {
                    Text("수정")
                }
                
                Button(role: .destructive) {
                    showDeleteAlert = true
                } label: {
                    Text("삭제")
                }
            }
        }
        .sheet(isPresented: $showDetailView) {
            ProductAddView(item: productDetailViewModel.item)
        }
        .alert("정말 삭제할까요?", isPresented: $showDeleteAlert) {
            Button("OK", role: .destructive) {
                productDetailViewModel.deleteProduct(id: productDetailViewModel.getID())
                dismiss()
            }
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProductDetailView()
        }
    }
}
