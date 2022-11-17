//
//  ContentView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject private var productListViewModel = ProductListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(productListViewModel.lists, id: \.id) { data in
                    HStack {
                        AsyncImage(url: URL(string: data.thumbnail)) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                            case .failure:
                                Image(systemName: "wifi.slash")
                            @unknown default:
                                Image(systemName: "photo")
                            }
                        }
                        .frame(width: 100, height: 100)

                        VStack {
                            Text(data.name)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(0)

                            Text("\(data.price)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .lineLimit(0)
                        }
                        .padding()
        
                        Text("\(data.stock)")
                            .frame(alignment: .trailing)
                    }
                }
            }
            .onAppear {
                productListViewModel.getProduct(page: 1, size: 20)
                
                print("onAppear")
            }
            .navigationTitle("List")
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
