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
                
                Text( "Welcome\nto our store")
                    .font(.customfont(.semibold, fontSize: 48))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text( "Step Inside Your Imagination: LiDAR-Powered Design with Neohome")
                    .font(.customfont(.medium, fontSize: 16))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)

                NavigationLink(destination: LoginView()) {
                                    Text("Login")
                        .font(.customfont(.semibold, fontSize: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 60, maxHeight: 60)
                        .background(Color.primaryApp)
                        .cornerRadius(20)
                                }
                                .buttonStyle(.bordered)

                Spacer()
                    .frame(height: 80)
            }
            .padding(.horizontal , 20)
        }
//        .navigationTitle("")
//        .navigationBarBackButtonHidden(true)
//        .navigationBarHidden(true)
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
