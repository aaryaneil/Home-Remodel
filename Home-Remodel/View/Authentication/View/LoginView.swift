//
//  LoginView.swift
//  HomeRemodel
//
//  Created by Aaryaneil Nimbalkar on 8/7/23.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    
    var body: some View {
        NavigationView {
            
            //form fields
            VStack {
                VStack(spacing: 24) {
                    InputView(text: $email,
                              title: "Email Address",
                              placeholder: "name@example.com",
                              isSecureField: false)
                    .autocapitalization(.none)
                    
                    InputView(text: $password,
                              title: "Password",
                              placeholder: "Enter your  password",
                              isSecureField: true)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                
                
                
                //sign in button
                
                Button {
                    print("log user in...")
                    Task {
                        try await viewModel.signIn(withEmail: email, password: password)
                    }
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .fontWeight(.semibold)
                        
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 32,
                           height: 48)
                }
                .background(Color(.systemBlue))
                .disabled(!formIsValid)
                .opacity(formIsValid ? 1.0 : 0.5)
                .cornerRadius(10)
                .padding(.top, 24)
                
                
                NavigationLink {
                    RegistrationView()
                        .navigationBarBackButtonHidden(true)
                } label: {
                    HStack(spacing: 3) {
                        Text("Don't have an account yet?")
                        Text("Sign up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
            }
        }
    }
}

//


extension LoginView: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
    
    
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
