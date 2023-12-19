//
//  Grid_SwiftUIApp.swift
//  Grid SwiftUI
//
//  Created by salome on 18.12.23.
//

import SwiftUI

@main
struct Grid_SwiftUIApp: App {
    @State private var viewModel = ProductViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView() {
                
                ProductGridView(viewModel: viewModel)
                
                    .navigationTitle("product grid")
            }
        }
    }
}
