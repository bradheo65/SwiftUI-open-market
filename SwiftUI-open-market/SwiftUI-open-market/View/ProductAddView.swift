//
//  ProductAddView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import SwiftUI

struct ProductAddView: View {
    
    private enum Field {
        case title
        case price
        case discountPrice
        case stock
        case description
    }
    
    var item: DetailProduct?
    
    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var productAddViewModel = ProductAddViewModel()
    
    @State private var showingImagePicker = false
    @State private var pickedImage: Image?
    
    @FocusState private var focusedField: Field?

    var body: some View {
        ScrollView {
            ScrollView(.horizontal) {
                HStack {
                    if productAddViewModel.detailImageArray.count == 0 {
                        ForEach(0..<productAddViewModel.imageArray.count, id: \.self) { images in
                            Image(uiImage: productAddViewModel.imageArray[images])
                                .resizable()
                                .frame(width: 150, height:150)
                        }
                    } else {
                        ForEach(0..<productAddViewModel.detailImageArray.count, id: \.self) { images in
                            CacheAsyncImage(url: URL(string: productAddViewModel.detailImageArray[images].url)!) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .frame(width: 150, height: 150)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 150, height: 150)
                        }
                    }
                    
                    if productAddViewModel.imageArray.count < 5 || productAddViewModel.detailImageArray.count < 5 {
                        Button(action: {
                            self.showingImagePicker.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .frame(width: 150, height: 150)
                                .background(.gray)
                            
                        }).sheet(isPresented: $showingImagePicker) {
                            ImagePicker(sourceType: .photoLibrary) { (image) in
                                productAddViewModel.imageArray.append(image)
                            }
                        }
                    }
                }
            }
            TextField("?????????", text: $productAddViewModel.title)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .title)
            
            HStack {
                TextField("????????????", text: $productAddViewModel.price)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .textFieldStyle(.roundedBorder)
                    .focused($focusedField, equals: .price)
                    .keyboardType(.numberPad)
                
                Picker("??????", selection: $productAddViewModel.currency) {
                    Text(Currency.KRW.rawValue)
                        .tag(Currency.KRW)
                    Text(Currency.USD.rawValue)
                        .tag(Currency.USD)
                }
                .pickerStyle(.segmented)
            }
            
            TextField("????????????", text: $productAddViewModel.discountedPrice)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .discountPrice)
                .keyboardType(.numberPad)
            
            TextField("????????????", text: $productAddViewModel.stock)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
                .focused($focusedField, equals: .stock)
                .keyboardType(.numberPad)
            
            ZStack {
                TextEditor(text: $productAddViewModel.description)
                    .frame(minHeight: 300, maxHeight: .infinity)
                    .cornerRadius(15)
                    .border(Color(uiColor: .secondarySystemBackground), width: 1)
                    .focused($focusedField, equals: .description)

                if productAddViewModel.description.isEmpty {
                    Text("?????? ????????? ??????????????????")
                        .foregroundColor(Color(uiColor: .placeholderText))
                        .padding(.top, 5)
                        .padding(.leading, 5)
                        .frame(maxWidth: .infinity,
                               maxHeight: .infinity,
                               alignment: .topLeading)
                        .cornerRadius(15)
                }
            }
        }
        .padding()
        .navigationTitle(item != nil ? "????????????" : "????????????" )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Done") {
                    if item != nil {
                        productAddViewModel.patch(id: item?.id ?? 0)
                    } else {
                        productAddViewModel.post()
                    }
                }
            }
            ToolbarItem(placement: .keyboard) {
                Button("??????") {
                    hideKeyboard()
                }
            }
            ToolbarItem(placement: .keyboard) {
                Button("??????") {
                    switch focusedField {
                    case .title:
                        focusedField = .price
                    case .price:
                        focusedField = .discountPrice
                    case .discountPrice:
                        focusedField = .stock
                    case .stock:
                        focusedField = .description
                    case .description:
                        hideKeyboard()
                    case .none:
                        hideKeyboard()
                    }
                }
            }
        }
        .onAppear {
            if item != nil {
                productAddViewModel.fetch(item: item!)
            }
        }
        .alert("????????? ??????",
               isPresented: $productAddViewModel.isPostSuccess) {
            Button("OK") {
                dismiss()
            }
        }
        .alert("????????? ??????",
               isPresented: $productAddViewModel.isPostFail) {
            Button("OK", role: .destructive) {
                dismiss()
            }
        }
        .alert("?????? ??????",
               isPresented: $productAddViewModel.isPatchSuccess) {
            Button("OK") {
                dismiss()
            }
        }
        .alert("?????? ??????",
               isPresented: $productAddViewModel.isPatchFail) {
            Button("OK", role: .destructive) {
                dismiss()
            }
        }
    }
}

struct ProductAddView_Previews: PreviewProvider {
    static var previews: some View {
        ProductAddView()
    }
}

