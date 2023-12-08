//
//  PurchaseView.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//


import SwiftUI

struct PurchaseView: View {
    
    @EnvironmentObject var productVM: ProductViewModel
    @Environment(\.dismiss) var dismiss
    var productIDs = [String]()
    
    //personal data
    @State private var firstname = ""
    @State private var lastname = ""
    
    //residence details
    @State private var city = ""
    @State private var street = ""
    @State private var streetNumber = ""
    @State private var houseNumber = ""
    
    //payment details
    @State private var cardHolderFirstname = ""
    @State private var cardHolderLastname = ""
    @State private var cardNumber = ""
    @State private var cardExpirationDate = ""
    @State private var cardCVV = ""
    
    var allFieldsAreFilled: Bool {
        return self.firstname != "" && self.lastname != "" && self.city != "" && self.street != "" && self.streetNumber != "" && self.cardNumber != "" && self.cardHolderLastname != "" && self.cardHolderFirstname != "" && self.cardExpirationDate != "" && self.cardNumber != ""  && self.cardCVV != ""
    }
    
    var body: some View {
        
        NavigationView {
            if self.productIDs.count > 0 {
                VStack{
                    Form {
                        Section(header: Text("The recipient's details")) {
                            TextField("Recipient's firstname", text: $firstname)
                            TextField("Recipient's lastname", text: $lastname)
                        }
                        Section(header: Text("The recipient's address")) {
                            TextField("City", text: $city)
                            TextField("Street", text: $street)
                            TextField("Street number", text: $streetNumber)
                            TextField("House number", text: $houseNumber)
                        }
                        Section(header: Text("Payment card details")) {
                            TextField("Cardholder's firstname", text: $cardHolderFirstname)
                            TextField("Cardholder's lastname", text: $cardHolderLastname)
                            TextField("Card number", text: $cardNumber)
                            TextField("Card expiration date", text: $cardExpirationDate)
                            SecureField("CVV card code", text: $cardCVV)
                        }
                    }
                    .textFieldStyle(.roundedBorder)
                    .listRowInsets(EdgeInsets())
                    .foregroundColor(.black)
                    .scrollContentBackground(.hidden)
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationTitle("Make a purchase")
                    Spacer()
                    
                    Button {
                        if allFieldsAreFilled {
                            productVM.submitOrder(productIDs: self.productIDs, firstName: self.firstname, lastName: self.lastname, city: self.city, street: self.street, streetNumber: self.streetNumber, houseNumber: self.houseNumber, cardNumber: self.cardNumber, cardHolderFirstname: self.cardHolderFirstname, cardHolderLastname: self.cardHolderLastname, cardCVV: self.cardCVV, cardExpirationDate: self.cardExpirationDate, totalPrice: self.productVM.userCartTotalPrice)
                            self.dismiss()
                        } else {
                            productVM.alertTitle = "Error"
                            productVM.alertMessage = "Fields cannot be empty"
                            productVM.showingAlert = true
                        }
                    } label: {
                        HStack{
                            Image(systemName: "eye").bold().font(.body)
                            Text("Buy").bold().font(.body)
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
            else{
                Text("You have no product in your cart.")
                Spacer()
            }
        }
        .alert(isPresented: $productVM.showingAlert){
            Alert(
                title: Text(productVM.alertTitle),
                message: Text(productVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct PurchaseCartLoader: View{
    
    @State var productID: String
    @EnvironmentObject var productVM: ProductViewModel
    
    var body: some View{
        ScrollView{
            LazyVStack{
                if self.productVM.products != nil{
                    ForEach(self.productVM.products!.filter{$0.id.contains(self.productID)}, id: \.id){ product in
                        PurchaseCartCell(product: product)
                            
                        Divider()
                            .overlay(Color("Primary"))
                    }
                }
            }
        }
    }
}


struct PurchaseCartCell: View{
    
    @State var product: Product
    @EnvironmentObject var productVM: ProductViewModel
    @State var quantity = 0

    var body: some View{
        VStack(alignment: .leading){
            HStack{
                ProductSearchCellImage(imageURL: product.imageURL).padding(.leading)
                VStack{
                    HStack{
                        Text(product.name)
                            .lineLimit(2)
                            .font(.callout)
                            .foregroundColor(.black)
                        Spacer()
                        
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
                        }
                    }
                }
            }
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}
