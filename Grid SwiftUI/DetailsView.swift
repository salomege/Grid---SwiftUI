//
//  DetailsView.swift
//  Grid SwiftUI
//
//  Created by salome on 19.12.23.
//

import SwiftUI

struct DetailView: View {
    let product: Product

    var body: some View {
        VStack {
            ForEach(product.images, id: \.self)
            { imageName in
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width:150, height: 50)
                    .onAppear() {
                        print("Image \(imageName) appeared")}
            }
            
            Text(product.description)
                .font(.title)

            Text("Price: $\(product.price)")
                .foregroundColor(.secondary)

            Text("Rating: \(product.rating, specifier: "%.2f")")
                .foregroundColor(.secondary)
                .font(.system(size: 16))


            NavigationLink(destination: CategoryView(viewModel: ProductViewModel())) {
                Text("Return to Categories")
            }
        }
        .padding()
        .navigationBarTitle(product.description)
    }
}
    

