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
            List(productListViewModel.lists, id: \.id) { data in
                NavigationLink (destination: ProductDetailView(item: data.id), label: {
                    ProductListCellView(data: data)
                        .task {
                            if data == productListViewModel.lists.last {
                                await productListViewModel.getProduct()
                            }
                        }
                })
            }
            .task {
                productListViewModel.getProduct()
            }
            .refreshable(action: {
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
