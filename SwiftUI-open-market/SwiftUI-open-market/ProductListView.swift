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
                        Image(data.thumbnail)
                        
                        VStack {
                            Text(data.name)
                                .frame(maxWidth: .infinity, alignment: .leading)

                            Text("\(data.price)")
                                .frame(maxWidth: .infinity, alignment: .leading)

                        }
                        Text("\(data.stock)")
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
            .onAppear {
                productListViewModel.getProduct(page: 1, size: 20)
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
