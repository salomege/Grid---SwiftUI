//
//  ProductViewModel.swift
//  Grid SwiftUI
//
//  Created by salome on 18.12.23.
//
import Foundation
import SwiftUI

struct ProductData: Decodable {
    let products: [Product]
}

class ProductViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var productQuantity: Int = 3
    @Published var totalProductPrice: Double = 100.0
    @Published var userBalance: Double  = 1000.0
    @Published var isLoaderVisible: Bool = false

    func fetchData() {
        guard let url = URL(string: "https://dummyjson.com/products") else { return }

        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let data = data {
                do {
                    let productData = try JSONDecoder().decode(ProductData.self, from: data)
                    DispatchQueue.main.async {
                        self?.products = productData.products
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }

    func addToCart(product: Product) {
        productQuantity += 1
        totalProductPrice += Double(product.price)
    }

    func simulatePurchase(completion: @escaping (Bool) -> Void) {
        isLoaderVisible = true

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            if self.userBalance >= self.totalProductPrice {
                self.isLoaderVisible = false
                self.productQuantity = 0
                self.totalProductPrice = 0
                self.userBalance -= self.totalProductPrice
                completion(true)
            } else {
                self.isLoaderVisible = false
                completion(false)
            }
        }
    }
}



