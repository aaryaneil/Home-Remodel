//
//  ProductDetailView.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 8/10/23.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    @State private var rate = [Int]()
    @State private var review = [String]()
    @State private var ratedByUID = [String]()
    @State private var ratedBy = [String]()
    @State private var ratesTotal: Int = 0
    @State private var ratesCount: Int = 0
    @State private var ratesAverage: Double = 0.0
    @State private var currentReviewIndex: Int = 0
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var userVM: UserViewModel
    @State private var showingReviewView = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack {
            Color("Bg")
            ScrollView  {
                
                //Product Image
                ProductImageView(product: product)
                        
                
                DescriptionView(product:product)
                
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
            
            .edgesIgnoringSafeArea(.top)
            
            HStack {
                if product.isOnSale {
                    VStack {
                        Text("$\(product.price)")
                            .font(.callout)
                            .strikethrough()
                            .foregroundColor(.white).opacity(0.75)
                            .frame(alignment: .trailing)
                        
                        Text("$\(product.onSalePrice)")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
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
                Spacer()
                Button {
                    productVM.addProductToCart(productID: product.id)
                } label: {
                    Text("Add to Cart")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("Primary"))
                        .padding()
                        .padding(.horizontal, 8)
                        .background(Color.white)
                        .cornerRadius(10.0)
                }
            }
            .padding()
            .padding(.horizontal)
            .background(Color("Primary"))
            .cornerRadius(60.0, corners: .topLeft)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: BackButton(action: {presentationMode.wrappedValue.dismiss()}), trailing: Image("threeDot"))
    }
}


struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.sampleProduct)
            .environmentObject(ProductViewModel())
            .environmentObject(UserViewModel())
    }
}

struct ColorDotView: View {
    let color: Color
    var body: some View {
        color
            .frame(width: 24, height: 24)
            .clipShape(Circle())
    }
}

struct DescriptionView: View {
    @State private var showingReviewView = false
    // Rating and reviews
    @EnvironmentObject var userVM: UserViewModel
    @EnvironmentObject var productVM: ProductViewModel
    @State private var rate = [Int]()
    @State private var review = [String]()
    @State private var ratedByUID = [String]()
    @State private var ratedBy = [String]()
    @State private var ratesTotal: Int = 0
    @State private var ratesCount: Int = 0
    @State private var ratesAverage: Double = 0.0
    @State private var currentReviewIndex: Int = 0
    var product: Product
    var body: some View {
        @State var isHeartFilled = false
        VStack (alignment: .leading) {
            //                Title
            Text(product.name.uppercased())
                .font(.title3).bold()
                .multilineTextAlignment(.center)
                .lineLimit(3)
                .padding()
            //                Rating
            HStack (spacing: 4) {
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
                Spacer()
                Button(action: {
                    productVM.addProductToWatchList(productID: product.id)
                                    isHeartFilled.toggle()
                                }) {
                                    Image(systemName: isHeartFilled ? "heart.fill" : "heart")
                                        .foregroundColor(isHeartFilled ? .red : .gray)
                                }
            }
            
            Text("Description")
                .fontWeight(.medium)
                .padding(.vertical, 8)
            Text(product.description)
                .lineSpacing(8.0)
                .opacity(0.6)
            
            if !product.details.isEmpty {
                    Text("Specification")
                    .fontWeight(.medium)
                    .padding(.vertical, 8)
                    
                    ForEach(product.details, id: \.self) { detail in
                        Divider()
                        Text(detail)
                    }
                    .padding(.horizontal, 8)
                }
            VStack(alignment: .center){
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
            //                Info
            
            //                Colors and Counter
            
        }
        .padding()
        .padding(.top)
        .background(Color("Bg"))
        .cornerRadius(30, corners: [.topLeft, .topRight])
        .offset(x: 0, y: -30.0)
    }
}
struct ProductImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.white)
                .cornerRadius(14)
                .overlay(
                    ZStack {
                        ProgressView()
                        if imageLoader.image != nil {
                            HStack {
                                Image(uiImage: imageLoader.image!)
                                    .resizable()
                                    .scaledToFill()  // Ensure the image fills the space
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                                    .cornerRadius(14)
                                    .clipped()
                            }
                        }
                    }
                )
        }
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
    }
}

struct ProductImageView: View {
    var product: Product
    @State private var currentIndex: Int = 0
    
    var body: some View {
        if product.images.count > 0 {
            TabView(selection: $currentIndex) {
                ForEach(0..<product.images.count, id: \.self) { index in
                    ProductImage(imageURL: URL(string: product.images[index])!)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .frame(minHeight: 350)
            
            .onAppear {
                UIPageControl.appearance().currentPageIndicatorTintColor = .black
                UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
            }
        } else {
            ProductImage(imageURL: product.imageURL)
        }
    }
}


struct BackButton: View {
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: "chevron.backward")
                .foregroundColor(.black)
                .padding(.all, 12)
                .background(Color.white)
                .cornerRadius(8.0)
        }
    }
}
