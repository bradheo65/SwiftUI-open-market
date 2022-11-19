//
//  ContentView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/17.
//

import SwiftUI

struct ProductListView: View {
    
    @ObservedObject private var productListViewModel = ProductListViewModel()
    var page = 20
    
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

                            Text("\(Int(round((data.bargainPrice))))")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .lineLimit(0)
                        .padding()
        
                        Text("\(Int(round(data.stock)))")
                            .frame(alignment: .trailing)
                        }

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
            .navigationTitle("List")
            .listStyle(.grouped)
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListView()
    }
}
