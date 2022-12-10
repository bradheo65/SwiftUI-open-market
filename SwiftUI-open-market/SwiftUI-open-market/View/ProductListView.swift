//
//  ContentView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject private var productListViewModel = ProductListViewModel()
    
    @State private var showAddView = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(productListViewModel.lists, id: \.id) { data in
                    NavigationLink (destination: ProductDetailView(item: data.id), label: {
                        HStack {
                            CacheAsyncImage(
                                url: productListViewModel.getURL(Product: data)) {
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
                                    Text(productListViewModel.getName(Product: data))
                                        .frame(maxWidth: .infinity,
                                               alignment: .leading)
                                        .font(.title3)
                                        .lineLimit(1)
                                    if data.stock != 0 {
                                        HStack {
                                            Text("잔여수량:")
                                            Text(productListViewModel.getStock(Product: data))
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
                                                Text(productListViewModel.getCurrency(Product: data))
                                                Text(productListViewModel.getPrice(Product: data))
                                            }
                                            .font(.system(size: 15))
                                            .foregroundColor(.red)
                                            .strikethrough()
                                            
                                            HStack {
                                                Text(productListViewModel.getCurrency(Product: data))
                                                Text(productListViewModel.getBargainPrice(Product: data))
                                            }
                                            .font(.system(size: 15))
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                        }
                                        .frame(maxWidth: .infinity,
                                               alignment: .leading)
                                    } else {
                                        HStack {
                                            Text(productListViewModel.getCurrency(Product: data))
                                            Text(productListViewModel.getPrice(Product: data))
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
                    })
                }
                if productListViewModel.isFull == false {
                    ProgressView()
                        .onAppear {
                            productListViewModel.getProduct()
                        }
                }
            }
            .task {
                productListViewModel.getProduct()
            }
            .refreshable(action: {
                await Task.sleep(1_000_000_000)
                productListViewModel.getProduct()
            })
            .navigationTitle("Open Market")
            .toolbar {
                NavigationLink {
                    ProductAddView()
                } label: {
                    Image(systemName: "plus")
                }
            }
            .listStyle(.grouped)
            .sheet(isPresented: $showAddView) {
                ProductAddView()
            }
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
