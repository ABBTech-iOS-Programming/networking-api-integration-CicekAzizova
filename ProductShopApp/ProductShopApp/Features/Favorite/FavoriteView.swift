//
//  FavoriteView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct FavoriteView: View {
    
    @Bindable var viewModel: ProductViewModel
    
    var favoriteProducts: [Product] {
        viewModel.products.filter({ $0.isFavorite })
    }
    
    private var hasFavorite: Bool {
        viewModel.products.contains { $0.isFavorite }
    }
    var body: some View {
        if hasFavorite {
            List {
                ForEach(favoriteProducts) {product  in
                    
                    NavigationLink(value: product) {
                        FavoriteCardView(viewModel: viewModel, product: product)
                    }
                    .buttonStyle(.plain)
                    
                    .padding()
                    
                    
                }
            }
            .navigationDestination(for: Product.self) { product in
                if let index = viewModel.products.firstIndex(where: { $0.id == product.id }) {
                    ProductDetailsView(viewModel: viewModel, product: $viewModel.products[index])
                }
                
            }
        }
        else {
            ContentUnavailableView("No Favorites Yet", systemImage: "heart")
        }
    }
}

#Preview {
    FavoriteView(viewModel: ProductViewModel())
}
