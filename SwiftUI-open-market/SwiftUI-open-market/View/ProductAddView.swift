//
//  ProductAddView.swift
//  SwiftUI-open-market
//
//  Created by brad on 2022/11/20.
//

import SwiftUI

enum Currency: String {
    case KRW = "KRW"
    case USD = "USD"
}

struct ProductAddView: View {
    
    private var productAddViewModel = ProductAddViewModel()
    
    @State private var showingImagePicker = false
    @State private var pickedImage: Image?
    @State private var imageArray: [UIImage] = []

    @State private var title: String = ""
    @State private var price: String = ""
    @State private var currency = Currency.KRW
    @State private var discountedPrice: String = ""
    @State private var stock: String = ""
    @State private var description: String = ""
    @State private var secret: String = "z1xc3q4v12b3b1ja3ou"

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<imageArray.count, id: \.self) { images in
                        Image(uiImage: imageArray[images])
                            .resizable()
                            .frame(width: 150, height:150)
                    }
                                    
                    if imageArray.count < 5 {
                        Button(action: {
                            self.showingImagePicker.toggle()
                        }, label: {
                            Image(systemName: "plus")
                                .frame(width: 150, height: 150)
                                .background(.gray)
                            
                        }).sheet(isPresented: $showingImagePicker) {
                            ImagePicker(sourceType: .photoLibrary) { (image) in
                                let imageSize = image.logImageSizeInKB(scale: image.scale)
                                if imageSize >= 300 {
                                    let resizeImage = productAddViewModel.resizeImage(image: image, height: 150)
                                    imageArray.append(resizeImage)
                                } else {
                                    imageArray.append(image)
                                }
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
            
            TextField("재고수량", text: $stock)
                .background(Color(uiColor: .secondarySystemBackground))
                .textFieldStyle(.roundedBorder)
            
            TextEditor(text: $description)
                .frame(maxHeight: .infinity)
                .cornerRadius(15)
                .border(Color(uiColor: .secondarySystemBackground), width: 1)

        }
        .padding()
        .navigationTitle("상품등록")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Button("Done") {
                productAddViewModel.postProduct(image: imageArray,
                                                name: title,
                                                descriptions: discountedPrice,
                                                price: Int(price) ?? 0,
                                                currency: currency.rawValue,
                                                discountPrice: Int(discountedPrice) ?? 0,
                                                stock: Int(discountedPrice) ?? 0,
                                                secret: secret)
            }
        }
    }
}

struct ProductAddView_Previews: PreviewProvider {
    static var previews: some View {
        ProductAddView()
    }
}
