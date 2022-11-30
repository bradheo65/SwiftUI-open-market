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
        NavigationView {
            List {
                ForEach(productListViewModel.lists, id: \.id) { data in
                    NavigationLink (destination: ProductDetailView(item: data.id), label: {
                        HStack {
                            AsyncImage(url: URL(string: data.thumbnail)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 80, height: 80)
                            
                            VStack {
                                Text(data.name)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .font(.title3)
                                HStack {
                                    if data.discountedPrice != 0 {
                                        Text("\(data.currency) \(Int(round((data.price))))")
                                            .frame(alignment: .leading)
                                            .font(.system(size: 15))
                                            .foregroundColor(.red)
                                            .strikethrough()
                                        
                                        Text("\(data.currency) \(Int(round((data.bargainPrice))))")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 15))
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                        
                                    } else {
                                        Text("\(data.currency) \(round((data.price)))")
                                            .frame(maxWidth: .infinity, alignment: .leading)
                                            .font(.system(size: 15))
                                            .foregroundColor(.secondary)
                                            .lineLimit(1)
                                    }
                                }
                            }
                            .lineLimit(0)
                            .padding()
                            
                            if data.stock != 0 {
                                Text("잔여수량: \(Int(round(data.stock)))")
                                    .frame(alignment: .trailing)
                                    .font(.system(size: 15))
                                    .foregroundColor(.secondary)
                                    .lineLimit(1)
                                
                            } else {
                                Text("품절")
                                    .frame(alignment: .trailing)
                                    .foregroundColor(.yellow)
                                    .lineLimit(1)
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
            .navigationTitle("List")
            .toolbar {
                Button {
                    showAddView = true
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
