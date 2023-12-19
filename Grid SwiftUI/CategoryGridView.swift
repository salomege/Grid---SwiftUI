//
//  CategoryGridView.swift
//  Grid SwiftUI
//
//  Created by salome on 19.12.23.
//

import SwiftUI

struct CategoryGridView: View {
    @ObservedObject var viewModel: ProductViewModel
    let selectedCategory: String

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                ForEach(viewModel.products.filter { $0.category == selectedCategory }, id: \.id) { product in
                    NavigationLink(destination: DetailView(product: product)) {
                        VStack(alignment: .leading) {
                            Image(product.images.first ?? "")
                            
                                .resizable()
                                .frame(width:100, height:100)
                                .scaledToFill()

                            Text("Price: $\(product.price)")
                                .foregroundColor(.secondary)

                            Text("Rating: \(product.rating, specifier: "%.2f")")
                                .foregroundColor(.secondary)
                                .font(.system(size: 12))
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
        }
        .navigationBarTitle(selectedCategory)
    }
}


// MARK: - Preview
//#Preview {
//    CategoryGridView(viewModel: ProductViewModel())
//        .environmentObject(ProductViewModel())
//}

