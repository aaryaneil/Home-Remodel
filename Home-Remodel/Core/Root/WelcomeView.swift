//
//  WelcomeView.swift
//

//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            Image("BG")
                .resizable()
                .scaledToFill()
                .frame(width: .screenWidth, height: .screenHeight)
            
            VStack{
                Spacer()
                
               // Image("app_logo")
                    //.resizable()
                  //  .scaledToFit()
                  //  .frame(width: 50, height: 60)
                  //  .padding(.bottom, 8)
                
                Text( "Welcome\nto our store")
                    .font(.customfont(.semibold, fontSize: 48))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text( "Step Inside Your Imagination: LiDAR-Powered Design with Neohome")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                
                NavigationLink {
                    LoginView()
                } label: {
                    RoundButton(title: "Get Started") {
                    }
                }

               
                
                Spacer()
                    .frame(height: 80)
                
            }
            .padding(.horizontal , 20)
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .ignoresSafeArea()
    }
        
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        
        NavigationView {
            WelcomeView()
        }
        
    }
}
