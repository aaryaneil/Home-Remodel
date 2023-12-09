//
//  ProductCarouselCard.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct ProductCarouselCard: View {
    
    var product: Product
    
    var body: some View {
        VStack {
            ProductCarouselImage(imageURL: product.imageURL)
            
            VStack(alignment: .center) {
                Text(product.name.uppercased())
                    .lineLimit(2)
                    .fixedSize(horizontal: false, vertical: true)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.top)
                
                if product.isOnSale {
                    VStack {
                        Text("$\(product.price)")
                            .bold()
                            .padding([.top, .leading, .trailing])
                            .font(.callout)
                            .strikethrough()
                            .foregroundColor(.black)
                            .opacity(0.75)
                            .frame(alignment: .trailing)
                        
                        Text("$\(product.onSalePrice)")
                    }
                    .frame(alignment: .center)
                    .padding(.bottom)
                } else {
                    Text("$\(product.price)")
                        .bold()
                        .padding(.bottom)
                }
            }
            .foregroundColor(.black)
            .opacity(0.9)
            
        }
        .frame(height: 200)
        .background(Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1)))
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.75), radius: 5, x: 1, y: 1)
        .padding([.leading, .trailing])
    }
}

struct ProductCarouselImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .frame(width: 100, height: 140)
                .cornerRadius(12)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Spacer()
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .compositingGroup()
                                    .clipped(antialiased: true)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(12)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                )
        }
        .padding(.leading)
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct ProductCarouselCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarouselCard(product: Product.sampleProduct)
    }
}
