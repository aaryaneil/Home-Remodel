//
//  Product.swift
//  Home-Remodel
//
//  Created by Aaryaneil Nimbalkar on 11/30/23.
//

import Foundation

struct Product: Codable, Identifiable {
    
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
}
