//
//  WatchListView.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct WatchListView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View {
        NavigationView {
            if self.productVM.userWatchListProductIDs.count > 0 {
                VStack{
                    Divider()
                    ScrollView{
                        if self.productVM.userWatchListProductIDs.count > 0 {
                            ForEach(0..<self.productVM.userWatchListProductIDs.count, id: \.self) { index in
                                ProductWatchListLoader(productID: self.productVM.userWatchListProductIDs[index])
                            }
                        }
                    }
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Favorites")
                }
                
            } else {
                Text("You are not following any product.")
                Spacer()
            }
        }
        .onAppear{
            productVM.getUserWatchList()
        }
    }
}


struct ProductWatchListLoader: View{
    
    var productID: String
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        ScrollView{
            LazyVStack{
                if self.productVM.products != nil{
                    ForEach(self.productVM.products!.filter{$0.id.contains(self.productID)}, id: \.id){ product in
                        NavigationLink(destination: ProductDetailsView(product: product)) {
                            ProductWatchListCell(product: product)}
                        Divider()
                            .overlay(Color("Primary"))
                    }
                }
            }
        }
    }
}

struct ProductWatchListCell: View{
    
    var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        VStack{
            HStack{
                ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
                VStack{
                    HStack{
                        Spacer()
                        Text(product.name)
                            .lineLimit(2)
                            .font(.callout)
                            .multilineTextAlignment(.center)
                            .padding([.leading, .trailing])
                            .foregroundColor(.black)
                        Spacer()
                        Button {
                            productVM.removeProductFromWatchList(productID: product.id)
                        } label: {
                            Image(systemName: "xmark")
                                .font(.title)
                                .padding([.leading, .trailing])
                                .clipShape(Circle())
                        }
                    }
                    HStack{
                        if product.isOnSale{
                            VStack{
                                Text("\(product.price)")
                                    .bold()
                                    .padding([.leading, .trailing])
                                    .font(.callout)
                                    .strikethrough()
                                    .foregroundColor(.black).opacity(0.75)
                                    .frame(alignment: .trailing)
                                
                                Text("$\(product.onSalePrice)")
                                    .padding([.leading,.trailing])
                                    .foregroundColor(.black)
                                    .font(.callout)
                            }
                            .frame(alignment: .center)
                        }
                        else {
                            Text("$\(product.price)")
                                .bold()
                                .font(.callout)
                                .foregroundColor(.black)
                                .padding()
                        }
                        Spacer()
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
                        .padding(.trailing)
                    }
                }
            }
        }
    }
}



struct ObservedView_Previews: PreviewProvider {
    static var previews: some View {
        WatchListView()
    }
}
