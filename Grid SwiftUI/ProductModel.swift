//
//  ProductModel.swift
//  Grid SwiftUI
//
//  Created by salome on 18.12.23.
//

import Foundation


struct productData: Decodable {
    let products: [Product]
    let total: Int
}

struct Product: Decodable {
    let id: Int
    let description: String
    let price: Int
    let rating: Double
    let stock: Int
    let category: String
    let images: [String]
    
}
    


