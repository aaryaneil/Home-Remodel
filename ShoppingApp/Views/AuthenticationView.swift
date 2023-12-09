//
//  AuthenticationView.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//


import SwiftUI


struct AuthenticationView: View {
    
    @EnvironmentObject var user: UserViewModel

    var body: some View {
        Spacer()
        SignInView()
        .alert(isPresented: $user.showingAlert){
            Alert(
                title: Text(user.alertTitle),
                message: Text(user.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        Spacer()
    }
}

struct SignInView: View {
    
    @EnvironmentObject var user: UserViewModel
    @State var email = ""
    @State var password = ""

    @State var isSecured: Bool = true
    
    var body: some View {
        VStack {
            VStack{
                VStack{
                    TextField("Email addresses", text: $email).padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("Password", text: $password).padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Password", text: $password).padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye").accentColor(.gray)
                        }.padding()
                        
                    }
                    
                    NavigationLink("Have you forgotten your password?", destination: ResetPasswordView())
                        .padding([.leading, .bottom, .trailing])
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .foregroundColor(Color("Primary"))
                    
                    Button {
                        if (!email.isEmpty && !password.isEmpty){
                            user.signIn(email: email, password: password)
                        } else{
                            user.alertTitle = "Error"
                            user.alertMessage = "Fields cannot be empty"
                            user.showingAlert = true
                        }

                    } label: {
                        Text("Login")
                            .frame(width: 200, height: 50)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color("Primary"))
                            .cornerRadius(45)
                            .padding()

                    }

                    Text("You do not have an account?")
                        .padding([.top, .leading, .trailing])
                    NavigationLink("Create an account", destination: SignUpView()).padding([.leading, .bottom, .trailing]).foregroundColor(Color("Primary"))

                }
                .padding()
                Spacer()
                
                Button {
                    user.signInAnonymously()
                } label: {
                    Text("Continue as a guest")
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color("Primary"))
                }
            }
            .navigationTitle("Login")
        }
    }
}

struct SignUpView: View {
    
    @State var email = ""
    @State var password = ""
    @State var passwordConfirmation = ""
    @State var username = ""
    
    @EnvironmentObject var user: UserViewModel

    @State var isSecured: Bool = true
    @State var isSecuredConfirmation: Bool = true

    var body: some View {
        VStack {
            VStack{
                VStack{
                    TextField("User Name", text: $username)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    TextField("Email addresses", text: $email)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecured {
                                SecureField("Password", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Password", text: $password)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecured.toggle()
                        } label: {
                            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }
                        .padding()
                    }
                    
                    ZStack(alignment: .trailing){
                        Group{
                            if isSecuredConfirmation {
                                SecureField("Password", text: $passwordConfirmation)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            } else {
                                TextField("Password", text: $passwordConfirmation)
                                    .padding()
                                    .disableAutocorrection(true)
                                    .autocapitalization(.none)
                                    .background(Color(.secondarySystemBackground))
                            }
                        }
                        Button {
                            isSecuredConfirmation.toggle()
                        } label: {
                            Image(systemName: self.isSecuredConfirmation ? "eye.slash" : "eye")
                                .accentColor(.gray)
                        }.padding()
                    }
                    
                    
                    
                    Button(action: {
                        if username.isEmpty || email.isEmpty || password.isEmpty || passwordConfirmation.isEmpty {
                            user.updateAlert(title: "Error", message: "Fields cannot be empty")
                            return
                        }

                        if password != passwordConfirmation {
                            user.updateAlert(title: "Error", message: "Passwords must be the same")
                            return
                        }

                        user.signUp(email: email, password: password, username: username)
                    }) {
                        Text("Create an account")
                            .foregroundColor(.white)
                            .padding()
                    }
                    .background(Color("Primary"))
                    .cornerRadius(45)
                    .alert(isPresented: $user.showingAlert) {
                        Alert(title: Text(user.alertTitle), message: Text(user.alertMessage), dismissButton: .default(Text("OK")))
                    }


                }
                .padding()
                Spacer()
            }
            .navigationTitle("Create an account")
        }
    }
}

struct ResetPasswordView: View {
    
    @State var email = ""
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack {
            VStack{
                VStack {
                    TextField("Email addresses", text: $email)
                        .padding()
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .background(Color(.secondarySystemBackground))
                    
                    Button(action: {
                        if !email.isEmpty {
                            user.resetPassword(email: email)
                        } else {
                            user.updateAlert(title: "Error", message: "Fields cannot be empty")
                        }
                    }) {
                        Text("Reset your password")
                            .frame(width: 200, height: 50)
                            .bold()
                            .foregroundColor(.white)
                            .background(Color("Primary"))
                            .cornerRadius(45)
                            .padding()
                    }
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Password recovery")
        }
        
    }
}
