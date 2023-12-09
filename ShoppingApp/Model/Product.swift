//
//  Product.swift
//  ShoppingApp
//
//  Created by Aaryaneil Nimbalkar on 12/7/23.
//

import Foundation


struct Product: Identifiable, Codable, Hashable {
    var id: String
    var name: String
    var img: String
    var price: Int
    var amount: Int
    var description: String
    var category: String
    var isOnSale: Bool
    var onSalePrice: Int
    
    var details : [String]
    var images : [String]
}

extension Product{
    var imageURL: URL {
        URL(string: img)!
    }
    
    static var sampleProducts: [Product] {
        return [Product(id: "zhTtJZBmWaBrLwawkGqL", name: "MALM" , img: "https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__0637611_pe698421_s5.jpg", price: 5500, amount: 3, description: "test", category: "Bedroom", isOnSale: true, onSalePrice: 5000, details: ["Bed frame" , "Queen"], images: ["https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__0321952_ph121261_s5.jpg","https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__1273465_pe930077_s5.jpg","https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__0485205_ph121284_s5.jpg"])]
    }
    
    static var sampleProduct: Product {
        return Product(id: "zhTtJZBmWaBrLwawkGqL", name: "MALM" , img: "https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__0637611_pe698421_s5.jpg", price: 5500, amount: 3, description: "test", category: "Bedroom", isOnSale: true, onSalePrice: 5000, details: ["Bed frame" , "Queen"], images: ["https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__0321952_ph121261_s5.jpg","https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__1273465_pe930077_s5.jpg","https://www.ikea.com/us/en/images/products/tarva-bed-frame-pine-luroey__0485205_ph121284_s5.jpg"])
    }


}
