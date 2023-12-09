//
//  ProductFilterView.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 12/8/23.
//

import SwiftUI

struct ProductFilterView: View {
    var category: String
    @EnvironmentObject var productVM: ProductViewModel
    @State private var products: [Product] = []

    var body: some View {
        ScrollView {
            if products.count > 0 {
                LazyVStack {
                    ForEach(products, id: \.id) { product in
                        NavigationLink(
                            destination: ProductDetailsView(product: product),
                            label: {
                                ProductCardView(product: product)
                            })
                            .navigationBarHidden(true)
                            .foregroundColor(.black)
                            .frame(width: 210, height: 380)
                            .padding(.bottom)
                    }
                }
            } else {
                Text("Temporarily no products in this category")
                    .padding()
                Spacer()
            }
        }
        .onAppear {
            self.products = self.productVM.products?.filter { $0.category.contains(self.category) } ?? []
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(category)
    }
}

