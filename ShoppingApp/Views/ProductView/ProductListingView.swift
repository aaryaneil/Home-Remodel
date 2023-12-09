//
//  ProductListingView.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 12/8/23.
//

//
//  ProductListingView.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 8/10/23.
//

import SwiftUI


struct ProductListingView: View {
    @State private var search: String = ""
    @State private var selectedIndex: Int = 1
    @EnvironmentObject var productVM: ProductViewModel
    @EnvironmentObject var userVM: UserViewModel
   
    private let categories = ["All", "Bedroom", "Living Room", "Bathroom", "Kitchen", "Dining"]
    var body: some View {
        NavigationView {
            ZStack {
                Color(#colorLiteral(red: 0.937254902, green: 0.937254902, blue: 0.937254902, alpha: 1))
                    .ignoresSafeArea()
                
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading) {
                        
                        TagLineView()
                            .padding()
                        
                        ScrollView (.horizontal, showsIndicators: false) {
                            HStack {
                                ForEach(0 ..< categories.count) { i in
                                    Button(action: {selectedIndex = i}) {
                                        CategoryView(isActive: selectedIndex == i, text: categories[i])
                                    }
                                }
                            }
                            .padding()
                        }
                        if selectedIndex > 0 {
                            ProductFilterView(category: categories[selectedIndex], productVM: _productVM)
                                                .environmentObject(productVM)
                                        }
                        else {
                            
                            
                            Text("Popular")
                                .font(.custom("PlayfairDisplay-Bold", size: 24))
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 40) {
                                    Group {
                                        if let promotedProducts = productVM.promotedProducts {
                                            ForEach(promotedProducts.indices, id: \.self) { i in
                                                NavigationLink(
                                                    destination: ProductDetailsView(product: promotedProducts[i]),
                                                    label: {
                                                        ProductCardView(product: promotedProducts[i])
                                                    })
                                                .navigationBarHidden(true)
                                                .foregroundColor(.black)
                                                .frame(width: 210, height:380)
                                            }
                                        } else {
                                            // Placeholder or loading state
                                            Text("Loading...")
                                        }
                                    }
                                    .padding(.leading)
                                }
                                .padding(.bottom)
                            }
                            
                            
                            Text("Best")
                                .font(.custom("PlayfairDisplay-Bold", size: 24))
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 40) {
                                    Group {
                                        if let onSaleProducts = productVM.onSaleProducts {
                                            ForEach(onSaleProducts.indices, id: \.self) { i in
                                                NavigationLink(
                                                    destination: ProductDetailsView(product: onSaleProducts[i]),
                                                    label: {
                                                        ProductCardView(product: onSaleProducts[i])
                                                    })
                                                .navigationBarHidden(true)
                                                .foregroundColor(.black)
                                                .frame(width: 210, height:380)
                                            }
                                        } else {
                                            // Placeholder or loading state
                                            Text("Loading...")
                                        }
                                    }
                                    .padding(.leading)
                                }
                            }
                            
                        }
                    }
                }
                
                VStack {
                    Spacer()
                    //TABVIEW
                }
            }
        }
//                .navigationBarTitle("") //this must be empty
//                .navigationBarHidden(true)
//                .navigationBarBackButtonHidden(true)
    }
}
struct ProductListingView_Previews: PreviewProvider {
    static var previews: some View {
        ProductListingView()
            .environmentObject(ProductViewModel())
    }
}




struct TagLineView: View {
    var body: some View {
        Text("Find the \nBest ")
            .font(.custom("PlayfairDisplay-Regular", size: 28))
            .foregroundColor(Color("Primary"))
        + Text("Furniture!")
            .font(.custom("PlayfairDisplay-Bold", size: 28))
            .fontWeight(.bold)
            .foregroundColor(Color("Primary"))
    }
}

struct RoomCaptureViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> RoomCaptureViewController {
        return RoomCaptureViewController()
    }

    func updateUIViewController(_ uiViewController: RoomCaptureViewController, context: Context) {
        // Update the view controller if necessary
    }
}

struct SearchAndScanView: View {
    
    @State private var isScannerViewPresented = false
    @Binding var search: String
    
    var body: some View {
        HStack {
            HStack {
                Image("Search")
                    .padding(.trailing, 8)
                TextField("Search Furniture", text: $search)
            }
            .padding(.all, 20)
            .background(Color.white)
            .cornerRadius(10.0)
            .padding(.trailing, 8)
      
            
            Button(action: {
                isScannerViewPresented = true
            }) {
                Image("Scanning")
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(10.0)
            }
            .fullScreenCover(isPresented: $isScannerViewPresented, content: {
                RoomCaptureViewControllerRepresentable()
                        })
        }
        .padding(.horizontal)
    }
}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Text(text)
                .font(.system(size: 18))
                .fontWeight(.medium)
                .foregroundColor(isActive ? Color("Primary") : Color.black.opacity(0.5))
            if (isActive) { Color("Primary")
                    .frame(width: 15, height: 2)
                    .clipShape(Capsule())
            }
        }
        .padding(.trailing)
    }
}

struct ProductCardView: View {
    var product: Product
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
                
            HStack(spacing: 10) {
                HStack{
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
                }
                Spacer()
                HStack{
                if product.isOnSale {
                    VStack {
                        Text("\(product.price)")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .strikethrough()
                            .foregroundColor(.black)
                            .opacity(0.75)
                            .frame(alignment: .trailing)
                        
                        Text("$\(product.onSalePrice)")
                            .font(.system(size: 14))
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
        }
        .frame(width: 210, height:380)
        .padding()
        .background(Color.white)
        .cornerRadius(20.0)
        
    }
}


//struct BottomNavBarView: View {
//    @EnvironmentObject var viewModel: AuthViewModel
//
//    var body: some View {
//        HStack {
//            BottomNavBarItem(image: Image("Home"), action: {})
//            BottomNavBarItem(image: Image("fav"), action: {})
//            BottomNavBarItem(image: Image("shop"), action: {})
//            BottomNavBarItem(image: Image("User"), action: {})
//        }
//        .padding()
//        .background(Color.white)
//        .clipShape(Capsule())
//        .padding(.horizontal)
//        .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
//    }
//}
//
//struct BottomNavBarItem: View {
//    let image: Image
//    let action: () -> Void
//    var body: some View {
//        Button(action: action) {
//            image
//                .frame(maxWidth: .infinity)
//        }
//    }
//}

