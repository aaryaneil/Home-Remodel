//
//  User.swift
//  HomeRemodel
//
//  Created by Aaryaneil Nimbalkar on 8/7/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    let fullName: String
    let email: String
    var address: String?
    var favoriteProducts: [Product]?
    
    var initials: String{
        let formatter = PersonNameComponentsFormatter()
        
        if let components = formatter.personNameComponents(from: fullName){
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
}


extension User{
    static var MOCK_USER = User(id: NSUUID().uuidString, fullName: "Kobe Bryant", email: "test@gmail.com", address: "328 N Market St,Los Angeles, CA.")
}
