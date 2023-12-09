//
//  ProductCard.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct ProductCard: View {
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var userVM: UserViewModel
    @State private var showingReviewView = false
    
    // Rating and reviews
    @State private var rate = [Int]()
    @State private var review = [String]()
    @State private var ratedByUID = [String]()
    @State private var ratedBy = [String]()
    @State private var ratesTotal: Int = 0
    @State private var ratesCount: Int = 0
    @State private var ratesAverage: Double = 0.0
    @State private var currentReviewIndex: Int = 0
    
    var body: some View {
        VStack {
            ProductCardImage(imageURL: product.imageURL)
                .frame(width: 200, height: 200)
                .cornerRadius(20.0)
            
            Text(product.name.uppercased())
                .font(.title3)
                .fontWeight(.bold)
            
            HStack(spacing: 2) {
                ForEach(0 ..< Int(self.ratesAverage), id: \.self) { _ in
                    Image(systemName: "star.fill")
                        .font(.callout)
                }
                
                if (self.ratesAverage != floor(self.ratesAverage)) {
                    Image(systemName: "star.leadinghalf.fill")
                        .font(.callout)
                }
                
                ForEach(0 ..< Int(Double(5) - self.ratesAverage), id: \.self) { _ in
                    Image(systemName: "star")
                        .font(.callout)
                }
                
                Spacer()
                
                if product.isOnSale {
                    VStack {
                        Text("\(product.price)")
                            .bold()
                            .foregroundColor(.black)
                            .font(.footnote)
                            .strikethrough()
                            .foregroundColor(.black)
                            .opacity(0.75)
                            .frame(alignment: .trailing)
                        
                        Text("$\(product.onSalePrice)")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    .frame(alignment: .center)
                } else {
                    Text("$\(product.price)")
                        .bold()
                        .foregroundColor(.black)
                }
            }
        }
        .frame(width: 200)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
        .shadow(color: .gray, radius: 4, x: 0.0, y: 0.0)
        .padding([.leading, .trailing])
    }
}

struct ProductCardImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .cornerRadius(20)
                                    .compositingGroup()
                                    .aspectRatio(contentMode: .fit)
                            }
                        }
        }
        .cornerRadius(12)
        .shadow(color: .gray, radius: 4, x: 0.0, y: 0.0)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: Product.sampleProduct)
    }
}
