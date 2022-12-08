//
//  ProductAddView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import SwiftUI

struct ProductAddView: View {
    
    var item: DetailProduct?

    @Environment(\.dismiss) private var dismiss
    
    @StateObject private var productAddViewModel = ProductAddViewModel()
    
    @State private var showingImagePicker = false
    @State private var pickedImage: Image?
    @State private var imageArray: [UIImage] = []
        
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    if productAddViewModel.detailImageArray.count == 0 {
                        ForEach(0..<imageArray.count, id: \.self) { images in
                            Image(uiImage: imageArray[images])
                                .resizable()
                                .frame(width: 150, height:150)
                        }
                    } else {
                        ForEach(0..<productAddViewModel.detailImageArray.count, id: \.self) { images in
                            AsyncImage(url: URL(string: productAddViewModel.detailImageArray[images].url)) { phase in
                                switch phase {
                                case .empty:
                                    ProgressView()
                                case .success(let image):
                                    image.resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(maxWidth: 150, maxHeight: 150)
                                case .failure:
                                    Image(systemName: "photo")
                                @unknown default:
                                    EmptyView()
                                }
                            }
                            .frame(width: 150, height: 150)
                        }
                    }
                    
                    if imageArray.count < 5 || productAddViewModel.detailImageArray.count < 5 {
                        Button(action: {
                            self.showingImagePicker.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .frame(width: 150, height: 150)
                                .background(.gray)
                            
                        }).sheet(isPresented: $showingImagePicker) {
                            ImagePicker(sourceType: .photoLibrary) { (image) in
                                imageArray.append(image)
                            }
                        }
                    }
                }
            }
            TextField("상품명", text: $productAddViewModel.title)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
            
            HStack {
                TextField("상품가격", text: $productAddViewModel.price)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numbersAndPunctuation)
                
                Picker("가격", selection: $productAddViewModel.currency) {
                    Text(Currency.KRW.rawValue)
                        .tag(Currency.KRW)
                    Text(Currency.USD.rawValue)
                        .tag(Currency.USD)
                }
                .pickerStyle(.segmented)
            }
            
            TextField("할인금액", text: $productAddViewModel.discountedPrice)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)
            
            TextField("재고수량", text: $productAddViewModel.stock)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)
            
            ZStack {
                TextEditor(text: $productAddViewModel.description)
                    .frame(maxHeight: .infinity)
                    .cornerRadius(15)
                    .border(Color(uiColor: .secondarySystemBackground), width: 1)
                
                if productAddViewModel.description.isEmpty {
                    Text("재품 설명을 작성해주세요")
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
        .navigationTitle(item != nil ? "상품편집" : "상품등록" )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Done") {
                    if item != nil {
                        productAddViewModel.patch(id: item?.id ?? 0,
                                                  image: imageArray,
                                                  name: productAddViewModel.title,
                                                  descriptions: productAddViewModel.description,
                                                  price: Int(productAddViewModel.price) ?? 0,
                                                  currency: productAddViewModel.currency.rawValue,
                                                  discountPrice: Int(productAddViewModel.discountedPrice) ?? 0,
                                                  stock: Int(productAddViewModel.stock) ?? 0
                        )
                    } else {
                        productAddViewModel.post(image: imageArray,
                                                 name: productAddViewModel.title,
                                                 descriptions: productAddViewModel.description,
                                                 price: Int(productAddViewModel.price) ?? 0,
                                                 currency: productAddViewModel.currency.rawValue,
                                                 discountPrice: Int(productAddViewModel.discountedPrice) ?? 0,
                                                 stock: Int(productAddViewModel.stock) ?? 0
                        )
                    }
                }
            }
        }
        .onAppear {
            if item != nil {
                productAddViewModel.fetch(item: item!)
            }
        }
        .alert("업로드 완료",
               isPresented: $productAddViewModel.isPostSuccess) {
            Button("OK") {
                dismiss()
            }
        }
        .alert("업로드 실패",
               isPresented: $productAddViewModel.isPostFail) {
            Button("OK", role: .destructive) {
                dismiss()
            }
        }
        .alert("수정 완료",
               isPresented: $productAddViewModel.isPatchSuccess) {
            Button("OK") {
                dismiss()
            }
        }
        .alert("수정 실패",
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

