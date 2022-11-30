//
//  ProductDetailView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/19.
//

import SwiftUI

struct ProductDetailView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var productDetailViewModel = ProductDetailViewModel()
    @State private var showAlert = false
    @State private var tag: Int? = nil
    @State private var currentImage: Int = 0
    @State private var showDetailView = false
    @State private var showDeleteAlert = false
    var item: Int = 0
    
    var body: some View {
        VStack {
            TabView(selection: self.$currentImage) {
                ForEach(0..<(productDetailViewModel.item?.images.count ?? 0), id: \.self) { images in
                    AsyncImage(url: URL(string: productDetailViewModel.item?.images[images].url ?? "")) { phase in
                        
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

            Text("\(currentImage + 1) / \(productDetailViewModel.item?.images.count ?? 0) ")
                .foregroundColor(.secondary)
            
            HStack {
                Text(productDetailViewModel.item?.name ?? "")
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(productDetailViewModel.item?.stock ?? 0)")
                    .frame(alignment: .trailing)
                    .foregroundColor(.secondary)
            }
            
            VStack(alignment: .trailing) {
                if productDetailViewModel.item?.discountedPrice != 0 {
                    Text("\(productDetailViewModel.item?.currency ?? "") \((productDetailViewModel.item?.price ?? 0))")
                        .font(.system(size: 15))
                        .foregroundColor(.red)
                        .strikethrough()
                    
                    Text("\(productDetailViewModel.item?.currency ?? "") \((productDetailViewModel.item?.bargainPrice ?? 0))")
                        .font(.system(size: 15))
                        .foregroundColor(.secondary)
                    
                } else {
                    Text("\(productDetailViewModel.item?.currency ?? "") \((productDetailViewModel.item?.price ?? 0))")
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
                productDetailViewModel.deleteProduct(id: productDetailViewModel.item?.id ?? 0)
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
