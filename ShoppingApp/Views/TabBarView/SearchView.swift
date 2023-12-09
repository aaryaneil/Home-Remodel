//
//  SearchView.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

enum Categories: String, CaseIterable{
    case all = "All"
    case bedroom = "Bedroom"
    case living_room = "Living Room"
    case bathroom = "Bathroom"
    case kitchen = "Kitchen"
    case dining = "Dining"
}

struct SearchView: View {
    
    @State var searchText = ""
    @EnvironmentObject var productVM: ProductViewModel

    var body: some View {
        NavigationView{
            VStack{
                if self.productVM.products != nil {
                    if !self.searchText.isEmpty {
                        ScrollView{
                            LazyVStack{
                                ForEach(self.productVM.products!.filter { $0.name.localizedCaseInsensitiveContains(searchText) }, id: \.id) { product in
                                    NavigationLink(destination: ProductDetailsView(product: product)) {
                                        SearchCell(product: product)
                                    }
                                    Divider().overlay(Color("Primary"))
                                }
                            }
                        }
                    } else {
                        List {
                            Section(header: Text("Category")) {
                                ForEach(Categories.allCases, id: \.rawValue) { item in
                                    NavigationLink(destination: SearchByCategory(category: item.rawValue), label: {
                                        Text(item.rawValue)
                                    })
                                }
                            }
                        }
                        .listStyle(.grouped)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Products").font(.headline).bold()
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink {
                        addNewProductView()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundColor(.orange)

                    }
                }
                
            }
        }

        .background(.gray.opacity(0.1))
        .searchable(text: $searchText)
        .autocorrectionDisabled(true)
        .autocapitalization(.none)
    }

}

struct SearchByCategory: View{
    
    var category: String
    @EnvironmentObject var productVM: ProductViewModel
    @State var productCounter: Int = 0

    var body: some View{
        NavigationView{
            if productCounter > 0 {
                ScrollView{
                    LazyVStack{
                        VStack{
                            Text("Found \(productCounter) products")
                            Divider()
                                .overlay(Color("Primary"))
                            if(self.productVM.products != nil){
                                ForEach(self.productVM.products!.filter{$0.category.contains(self.category) }, id: \.id) { product in
                                    SearchCell(product: product)
                                    Divider()
                                        .overlay(Color("Primary"))
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            } else {
                Text("Temporarily no products in this category")
                Spacer()
            }
            
        }
        .onAppear{
            self.productCounter = self.productVM.products!.filter{$0.category.contains(self.category) }.count
        }

        .navigationBarTitleDisplayMode(.inline)
        .navigationBarTitle(category)
        
    }

}

struct SearchCell: View{
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        HStack{
            ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
            VStack{
                Text(product.name)
                    .lineLimit(2)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                    .foregroundColor(.black)
                HStack{
                    Button {
                        productVM.addProductToCart(productID: product.id)
                    } label: {
                        HStack() {
                               Image(systemName: "cart.badge.plus")
                                .bold().font(.callout)
                               Text("To shopping cart")
                                .bold().font(.footnote)
                           }

                        .padding(8)
                        .foregroundColor(.white)
                        .background(Color("Primary"))
                        .cornerRadius(45)
                           
                    }
                    Spacer()
                    if product.isOnSale{
                        VStack{
                            Text("\(product.price)")
                                .bold()
                               .padding([.top, .leading, .trailing])
                                .font(.callout)
                                .strikethrough()
                                .foregroundColor(.black).opacity(0.75)
                                .frame(alignment: .trailing)

                            Text("$\(product.onSalePrice)")
                                .padding([.leading,.trailing])
                                .foregroundColor(.black)
                        }
                        .frame(alignment: .center)
                    }
                    else {
                        Text("$\(product.price)")
                            .bold()
                            .foregroundColor(.black)
                            .padding()
                    }
                    
                }

            }

        }
        
    }
    
}

struct ProductSearchCellImage: View {
    @StateObject private var imageLoader = ImageLoader()
    let imageURL: URL
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color.white)
                .frame(width: 80, height: 112, alignment: .center)
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
        .cornerRadius(12)
        .onAppear {
            imageLoader.loadImage(with: imageURL)
        }
        
    }
    
}

struct addNewProductView: View{
    @State var isOnSaleToggle: Bool = false
    @State var isPromotedToggle: Bool = false
    @State private var name = ""
    @State private var price = ""
    @State private var amount = ""
    @State private var description = ""
    @State private var onSalePrice = ""
    
    @EnvironmentObject var productVM: ProductViewModel
    @Environment(\.dismiss) var dismiss
    
    var allFieldsAreFilled: Bool {
        return self.name != "" && self.price != "" && self.amount != "" && self.description != "" && self.onSalePrice != ""
    }


    var body: some View {
        VStack{
            Form {
                TextField("Product name", text: $name)
                TextField("Product price", text: $price)
                TextField("Available quantity", text: $amount)
                TextField("Product description", text: $description)
                TextField("Promotional price", text: $onSalePrice)
                
                Toggle(
                    isOn: $isOnSaleToggle,
                    label: {
                        Text("Is it on sale?")
                    })
                .toggleStyle(SwitchToggleStyle(tint: .green))
                Toggle(
                    isOn: $isPromotedToggle,
                    label: {
                        Text("Is it promoted?")
                    })
                .toggleStyle(SwitchToggleStyle(tint: .green))
                Button {
                    //
                } label: {
                    Text("Add product photos")
                }
            }
            
            Spacer()
            Button {
                if allFieldsAreFilled {
                        //
                    self.dismiss()
                } else {
                    productVM.updateAlert(title: "Error", message: "Fields cannot be empty")
                }
            } label: {
                HStack{
                    Image(systemName: "eye").bold().font(.body)
                    Text("Add a product").bold().font(.body)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .foregroundColor(.white)
                .background(Color("Primary"))
                .cornerRadius(45)
            }
            .padding([.leading, .trailing, .bottom])

        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        //SearchCell(product: Product.sampleProduct)
        SearchView()
            .environmentObject(ProductViewModel())
    }
}
