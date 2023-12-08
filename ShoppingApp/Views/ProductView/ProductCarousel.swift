//
//  ProductCarousel.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct ProductCarousel: View {
    
    @State private var currentIndex: Int = 0
    
    let products: [Product]
    @State private var product: Product? = nil
    
    private let timer = Timer.publish(every: 6, on: .main, in: .common).autoconnect()
    private let screenSize = UIScreen.main.bounds

    var body: some View {
        VStack {
            TabView(selection: $currentIndex) {
                ForEach(0..<products.count, id: \.self) { index in
                    NavigationLink(destination: ProductDetailsView(product: products[index])) {
                        ProductCarouselCard(product: products[index])
                            .padding(.horizontal, 16)
                    }
                    .tag(index)
                }
            }
            .frame(height: 225)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onReceive(timer) { _ in
                animateCarousel()
            }
            .onAppear {
                setupAppearance()
            }
        }
    }
    
    func animateCarousel() {
        if currentIndex <= 3 {
            withAnimation {
                currentIndex += 1
            }
        } else {
            withAnimation {
                currentIndex = 0
            }
        }
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.black)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.black.opacity(0.2))
    }

}

struct ProductCarousel_Previews: PreviewProvider {
    static var previews: some View {
        ProductCarousel(products: Product.sampleProducts)
    }
}
