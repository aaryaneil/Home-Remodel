//
//  SwiftUIView.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 11/30/23.
//

import SwiftUI

struct BottomNavBarView: View {
    @EnvironmentObject var viewModel: AuthViewModel

    var body: some View {
        //var camera = Image("camera.viewfinder").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
        HStack {
            BottomNavBarItem(image: Image("Home"), destination: {AnyView(ProductListingView())})
            //BottomNavBarItem(image: Image("fav"),)
            BottomNavBarItem(image: Image("camera.viewfinder"), destination: {AnyView(CheckoutView())})
            BottomNavBarItem(image: Image("User"), destination: {AnyView(ProfileView())})
        }
        .padding()
        .background(Color.white)
        .clipShape(Capsule())
        .padding(.horizontal)
        .shadow(color: Color.blue.opacity(0.15), radius: 8, x: 2, y: 6)
    }
}

struct BottomNavBarItem: View {
    let image: Image
    let destination: () -> AnyView
    var body: some View {
        Button{
            image
                .frame(maxWidth: .infinity)
        } label: {
            NavigationLink(destination: destination()){
                image
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}
#Preview {
    BottomNavBarView()
}
