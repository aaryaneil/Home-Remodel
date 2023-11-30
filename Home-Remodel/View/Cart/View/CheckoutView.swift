//
import SwiftUI
//extension Color {
//static let backgroundColor = Color(red: 245/255, green: 245/255, blue: 245/255)
//}

struct CheckoutView: View {
    
    @State private var deliveryAddress: String = ""
    @State private var cardNumber: String = ""
    @State private var cardExpiry: String = ""
    @State private var cardCVV: String = ""
    @State private var promoCode: String = ""
    @State private var selectedDeliveryOption = 0
    let deliveryOptions = ["Standard Delivery", "Express Delivery", "In-store Pickup"]
    
    
    let bgColor = Color("BackgroundColor")
    let primaryColor = Color.blue
    let secondaryColor = Color.gray.opacity(0.2)
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    Image("productThumbnail")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .background(secondaryColor)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text("Product Name")
                            .font(.headline)
                        Text("Quantity: 1")
                        Text("$100.00")
                            .font(.title2)
                            .bold()
                    }
                }
                HStack {
                    Image("productThumbnail2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .background(secondaryColor)
                        .cornerRadius(10)
                    VStack(alignment: .leading) {
                        Text("Product Name 2")
                            .font(.headline)
                        Text("Quantity: 1")
                        Text("$150.00")
                            .font(.title2)
                            .bold()
                    }
                }
                
                
                TextField("Delivery Address", text: $deliveryAddress)
                    .padding()
                    .background(secondaryColor)
                    .cornerRadius(10)
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Payment Information").font(.headline)
                    TextField("Card Number", text: $cardNumber)
                    HStack {
                        TextField("MM/YY", text: $cardExpiry)
                        TextField("CVV", text: $cardCVV)
                    }
                }
                .padding()
                .background(secondaryColor)
                .cornerRadius(10)
                
                
                HStack {
                    Spacer()
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Order Summary").font(.headline)
                        Text("Product costs: $250.00")
                        Text("Taxes: $40.00")
                        Text("Delivery fees: $15.00")
                        Text("Total: $305.00").bold()
                    }
                }
                
                
                Picker("Delivery Options", selection: $selectedDeliveryOption) {
                    ForEach(deliveryOptions.indices, id: \.self) { index in
                        Text(deliveryOptions[index])
                    }
                }.pickerStyle(SegmentedPickerStyle())
                
                
                TextField("Enter Promo Code or Gift Card", text: $promoCode)
                    .padding()
                    .background(secondaryColor)
                    .cornerRadius(10)
                
                
                Button(action: {
                    
                }) {
                    Text("Checkout")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(primaryColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                }
                
                
                VStack(alignment: .leading, spacing: 10) {
                    Link("Return Policy", destination: URL(string: "https://yourwebsite.com/returnpolicy")!)
                        .foregroundColor(primaryColor)
                    Link("Customer Support", destination: URL(string: "https://yourwebsite.com/support")!)
                        .foregroundColor(primaryColor)
                }
                
            }
            .padding()
            .padding()
            //  .background(Color.backgroundColor)
            .cornerRadius(10)
        }
        // .background(Color.backgroundColor.ignoresSafeArea())
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
    }
}

