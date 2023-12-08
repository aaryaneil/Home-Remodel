//
//  ProductCardList.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct ProductCardList: View {
    
    let products: [Product]
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    @State private var product: Product? = nil

    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(products) { product in
                VStack {
                    NavigationLink(destination: ProductDetailsView(product: product)) {
                        ProductCard(product: product)
                            .padding(16)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
    }
}

struct ProductCardList_Previews: PreviewProvider {
    static var previews: some View {
        ProductCardList(products: Product.sampleProducts)
            .environmentObject(ProductViewModel())
    }
}
