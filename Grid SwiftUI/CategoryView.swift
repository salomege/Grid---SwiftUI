//
//  CategoryView.swift
//  Grid SwiftUI
//
//  Created by salome on 18.12.23.
//

import SwiftUI

struct CategoryView: View {
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(Array(Set(viewModel.products.map { $0.category })), id: \.self) { category in
                    NavigationLink(destination: CategoryGridView(viewModel: viewModel, selectedCategory: category)) {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "link.circle")
                                    .resizable()
                                    .frame(width: 35, height: 35)
                                
                                Text(category)
                                    .font(.title)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                            }
                        }
                        .padding(30)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
                .padding()
                .onAppear {
                    viewModel.fetchData()
                }
            }
            .navigationTitle("Categories")
        }
    }
}


#Preview {
    CategoryView(viewModel: ProductViewModel())
        .environmentObject(ProductViewModel())
}
