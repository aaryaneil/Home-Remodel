//
//  QuoteView.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 12/8/23.
//

import SwiftUI
struct QuoteView: View {
    var body: some View {
        VStack {
            Image("")//add image here
            Spacer()
            
            Text("Here is your real-time quote:")
                .font(.custom("PlayfairDisplay-Regular", size: 24))
                .foregroundColor(Color("Primary"))
            
            Spacer()
            
            Text("Kitchen Area: 66 sqft")
                .font(.custom("PlayfairDisplay-Bold", size: 24))
                .foregroundColor(Color("Primary"))
                .padding(.top, 8)
            
            Text("Your quote for this area is: $2340")
                .font(.custom("PlayfairDisplay-Regular", size: 24))
                .foregroundColor(Color("Primary"))
                .padding(.top, 16)
            
            Spacer()
            
            Button(action: {}) {
                Text("Accept Quote")
                    .font(.custom("PlayfairDisplay-Bold", size: 18))
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(Color("Primary"))
                    .cornerRadius(10.0)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 60)
        }
        .padding(.horizontal, 20)
        .background(Color.white)
        .cornerRadius(20.0)
        .shadow(color: Color.gray.opacity(0.3), radius: 8, x: 0, y: 4)
        .ignoresSafeArea()
    }
}

struct QuoteView_Previews: PreviewProvider {
    static var previews: some View {
        QuoteView()
    }
}
