//
//  ProductAddView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import SwiftUI

struct ProductAddView: View {
    
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var productAddViewModel = ProductAddViewModel()
    
    @State private var showingImagePicker = false
    @State private var pickedImage: Image?
    @State private var imageArray: [UIImage] = []
    @State private var detailImageArray: [DetailImage] = []
    
    @State private var title: String = ""
    @State private var price: String = ""
    @State private var currency = Currency.KRW
    @State private var discountedPrice: String = ""
    @State private var stock: String = ""
    @State private var description: String = ""
    
    var item: DetailProduct?
    
    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    if detailImageArray.count == 0 {
                        ForEach(0..<imageArray.count, id: \.self) { images in
                            Image(uiImage: imageArray[images])
                                .resizable()
                                .frame(width: 150, height:150)
                        }
                    } else {
                        ForEach(0..<detailImageArray.count, id: \.self) { images in
                            AsyncImage(url: URL(string: detailImageArray[images].url)) { phase in
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
                    
                    if imageArray.count < 5 || detailImageArray.count < 5 {
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
            TextField("상품명", text: $title)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
            
            HStack {
                TextField("상품가격", text: $price)
                    .background(Color(uiColor: .secondarySystemBackground))
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.numbersAndPunctuation)
                
                Picker("가격", selection: $currency) {
                    Text(Currency.KRW.rawValue)
                        .tag(Currency.KRW)
                    Text(Currency.USD.rawValue)
                        .tag(Currency.USD)
                }
                .pickerStyle(.segmented)
            }
            
            TextField("할인금액", text: $discountedPrice)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)
            
            TextField("재고수량", text: $stock)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
                .keyboardType(.numbersAndPunctuation)
            
            ZStack {
                TextEditor(text: $description)
                    .frame(maxHeight: .infinity)
                    .cornerRadius(15)
                    .border(Color(uiColor: .secondarySystemBackground), width: 1)
                
                if description.isEmpty {
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
                                                  name: title,
                                                  descriptions: description,
                                                  price: Int(price) ?? 0,
                                                  currency: currency.rawValue,
                                                  discountPrice: Int(discountedPrice) ?? 0,
                                                  stock: Int(stock) ?? 0
                        )
                    } else {
                        productAddViewModel.post(image: imageArray,
                                                 name: title,
                                                 descriptions: description,
                                                 price: Int(price) ?? 0,
                                                 currency: currency.rawValue,
                                                 discountPrice: Int(discountedPrice) ?? 0,
                                                 stock: Int(stock) ?? 0
                        )
                    }
                    dismiss()
                }
            }
        }
        .onAppear {
            if item != nil {
                detailImageArray = item?.images ?? []
                title = item?.name ?? ""
                price = item?.price.removeDecimal ?? ""
                discountedPrice = item?.discountedPrice.removeDecimal ?? ""
                stock = item?.stock.removeDecimal ?? ""
                description = item?.welcomeDescription ?? ""
            }
        }
    }
}

struct ProductAddView_Previews: PreviewProvider {
    static var previews: some View {
        ProductAddView()
    }
}

