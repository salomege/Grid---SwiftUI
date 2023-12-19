//
//  ProductGridView.swift
//  Grid SwiftUI
//
//  Created by salome on 18.12.23.
//


import SwiftUI

struct ProductGridView: View {
    @ObservedObject var viewModel: ProductViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        ScrollView {
            LazyVGrid(columns: Array(repeating: GridItem(), count: 2), spacing: 16) {
                ForEach(viewModel.products, id: \.id) { product in
                    VStack(alignment: .leading) {
                        Text(product.category)
                            .font(.headline)
                            .foregroundColor(.primary)

                        Text("Price: $\(product.price)")
                            .foregroundColor(.secondary)

                        Text("Rating: \(product.rating, specifier: "%.2f")")
                            .foregroundColor(.secondary)
                            .font(.system(size: 12))

                        Image(product.images.first ?? "")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFill()
                    }
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                }
            }
            .padding()
            .onAppear {
                viewModel.fetchData()
            }

            CartInfoView(viewModel: viewModel, showAlert: $showAlert, alertMessage: $alertMessage)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage))
        }
    }
}

struct CartInfoView: View {
    @ObservedObject var viewModel: ProductViewModel
    @Binding var showAlert: Bool
    @Binding var alertMessage: String

    var body: some View {
        VStack {
            Text("Added products quantity: \(viewModel.productQuantity)")
            Text("Added product price: $\(viewModel.totalProductPrice, specifier: "%.2f")")

            Button(action: {
                viewModel.simulatePurchase { success in
                    if success {
                        showAlert = true
                        alertMessage = "Checkout successful!"
                    } else {
                        showAlert = true
                        alertMessage = "Checkout failed. Insufficient balance."
                    }
                }
            }) {
                Text("Check Out")
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding()
    }
}

// MARK: - Preview

struct ProductGridView_Previews: PreviewProvider {
    static var previews: some View {
        ProductGridView(viewModel: ProductViewModel())
            .environmentObject(ProductViewModel())
    }
}
    
    
// MARK: - Preview
#Preview {
    ProductGridView(viewModel: ProductViewModel())
        .environmentObject(ProductViewModel())
}

