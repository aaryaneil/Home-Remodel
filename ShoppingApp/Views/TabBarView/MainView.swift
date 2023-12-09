//
//  MainView.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct MainView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
        @EnvironmentObject var userVM: UserViewModel
        @State private var search: String = ""

        var body: some View {
            NavigationView {
                ProductListingView()
                    .environmentObject(productVM)
                    .navigationBarTitleDisplayMode(.inline)
            }
            .onAppear {
                productVM.getPromotedProducts()
                productVM.getOnSaleProducts()
                productVM.getProducts()
                productVM.getUserWatchList()
                productVM.getUserCart()
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
        }
}
    




struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
        .environmentObject(ProductViewModel())
        .environmentObject(UserViewModel())
    }
}
