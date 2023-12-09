//
//  ProductDetailsView.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct ProductDetailsView: View {
    
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
    @State var isHeartFilled = false

    
    var body: some View {
        ZStack {
            Color("Bg")
            ScrollView {
                VStack {
                    ProductImageView(product: product)
                    
                    Spacer()
                    
                    ZStack {
                        Rectangle()
                            .fill(Color.white)
                            .cornerRadius(25)
                            .shadow(color: .black.opacity(0.5), radius: 3, x: 0.0, y: 0.0)
                        
                        VStack(alignment: .leading) {
                            Text(product.name.uppercased())
                                .font(.title3).bold()
                                .multilineTextAlignment(.center)
                                .lineLimit(3)
                                .padding()
                            
                            HStack{
                                HStack(spacing: 2) {
                                    ForEach(0 ..< Int(self.ratesAverage), id: \.self){ _ in
                                        Image(systemName: "star.fill").font(.callout)
                                    }
                                    
                                    if (self.ratesAverage != floor(self.ratesAverage)) {
                                        Image(systemName: "star.leadinghalf.fill").font(.callout)
                                        
                                    }
                                    ForEach(0 ..< Int(Double(5) - self.ratesAverage), id: \.self){ _ in
                                        Image(systemName: "star").font(.callout)
                                    }
                                    
                                    Text("(\(self.ratesTotal))").font(.footnote)
                                        .foregroundColor(.secondary)
                                        .offset(y: 3)
                                    
                                }
                                .padding([.bottom, .trailing, .leading])
                                Spacer()
                                if product.isOnSale {
                                    VStack {
                                        Text("$\(product.price)")
                                            .font(.callout)
                                            .strikethrough()
                                            .foregroundColor(Color("Primary")).opacity(0.75)
                                            .frame(alignment: .trailing)
                                        
                                        Text("$\(product.onSalePrice)")
                                            .font(.title2)
                                            .bold()
                                            .foregroundColor(Color("Primary"))
                                            .font(.headline)
                                    }
                                    .frame(alignment: .center)
                                    .padding([.bottom, .leading, .trailing])
                                } else {
                                    Text("$\(product.price)")
                                        .bold()
                                        .font(.headline)
                                        .padding([.bottom, .leading, .trailing])
                                }
                            }
                            HStack {
                                
                                
                                Button {
                                    productVM.addProductToWatchList(productID: product.id)
                                } label: {
                                    HStack {
                                        Image(systemName: "eye").bold().font(.body)
                                        Text("Favorite").bold().font(.body)
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color("Primary"))
                                    .cornerRadius(45)
                                }
                                .padding([.leading, .trailing])
                                Spacer()
                                Button {
                                    productVM.addProductToCart(productID: product.id)
                                } label: {
                                    HStack{
                                        Text("Add to Cart")
                                            .bold().font(.body)
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color("Primary"))
                                    .cornerRadius(45)
                                    
                                }
                                .padding([.leading, .trailing])
                            }
                            Text("Description")
                                .bold()
                                .font(.title2)
                                .padding()
                            
                            Text(product.description)
                                .foregroundColor(.black).opacity(0.75)
                                .padding([.leading, .trailing, .bottom])
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .lineLimit(100)
                            
                            if !product.details.isEmpty {
                                Text("Specification")
                                    .bold()
                                    .font(.title2)
                                    .padding()
                                
                                ForEach(product.details, id: \.self) { detail in
                                    Divider()
                                    Text(detail)
                                }
                                .padding(.horizontal, 8)
                            }
                            
                            VStack {
                                Button {
                                    if userVM.userIsAnonymous {
                                        productVM.updateAlert(title: "Attention", message: "You must be logged in to add a review!")
                                    } else {
                                        showingReviewView = true
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "plus").bold().font(.body)
                                        Text("Add your review").bold().font(.body)
                                    }
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color("Primary"))
                                    .cornerRadius(45)
                                }
                                HStack {
                                    Text("Reviews")
                                        .bold()
                                        .font(.title2)
                                        .padding(.top)
                                    Text("(\(self.ratesTotal))").font(.callout).offset(y: 10)
                                }
                                
                                if !self.rate.isEmpty {
                                    TabView(selection: $currentReviewIndex) {
                                        ForEach(0 ..< self.ratesTotal, id: \.self) { id in
                                            OpinionCard(rate: self.rate[id], review: self.review[id], username: self.ratedBy[id])
                                                .tag(id)
                                        }
                                    }
                                    .frame(height: 200)
                                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                                } else {
                                    Text("This product has no reviews")
                                }
                            }
                            
                            Spacer()
                        }
                    }
                    
                }
            }
            .sheet(isPresented: $showingReviewView) {
                RatingView(product: product)
                
            }
            .onAppear {
                productVM.getProductReviews(productID: product.id) { uid, rates, reviews, username, rateCount, rateTotal, rateAverage in
                    
                    rate = rates
                    review = reviews
                    ratedByUID = uid
                    ratedBy = username
                    ratesCount = rateCount
                    ratesTotal = rateTotal
                    ratesAverage = rateAverage
                }
            }
            
            .alert(isPresented: $userVM.showingAlert) {
                Alert(
                    title: Text(userVM.alertTitle),
                    message: Text(userVM.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
            .alert(isPresented: $productVM.showingAlert) {
                Alert(
                    title: Text(productVM.alertTitle),
                    message: Text(productVM.alertMessage),
                    dismissButton: .default(Text("OK"))
                )
                
        }
            Spacer()

        }
        .edgesIgnoringSafeArea(.top)
    }
    
}





struct ProductDetails_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailsView(product: Product.sampleProduct)
            .environmentObject(ProductViewModel())
            .environmentObject(UserViewModel())
    }
}
