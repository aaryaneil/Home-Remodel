//
//  ContentView.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var user: UserViewModel
    @EnvironmentObject var productVM: ProductViewModel
    
    // Define your custom color palette
    private let primaryColor = Color(#colorLiteral(red: 0.2, green: 0.4, blue: 0.6, alpha: 1))
    private let secondaryColor = Color("Primary")
    private let backgroundColor = Color.white
    
    var body: some View {
        NavigationView {
            if !user.userIsAuthenticated {
                AuthenticationView()
                    .navigationBarHidden(true)
                    .background(backgroundColor.edgesIgnoringSafeArea(.all))
            } else if !user.userIsAuthenticatedAndSynced {
                LoadingView()
                    .navigationBarHidden(true)
                    .background(backgroundColor.edgesIgnoringSafeArea(.all))
            } else {
                TabView {
                    MainView().tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }.tag(0)
                    SearchView().tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }.tag(1)
                    CartView().tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }.tag(2)
                    WatchListView().tabItem {
                        Image(systemName: "eye.fill")
                        Text("Watchlist")
                    }.tag(3)
                    ProfileView().tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }.tag(4)
                }
                .accentColor(primaryColor)
                .navigationBarHidden(true)
                .background(backgroundColor.edgesIgnoringSafeArea(.all))
            }
        }
        .onAppear {
            if user.userIsAuthenticated {
                user.syncUser()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserViewModel())
            .environmentObject(ProductViewModel())
    }
}
