//
//  FavoriteView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct FavoriteView: View {
    
    @Bindable var viewModel: ProductViewModel
    
    private var hasFavorite: Bool {
        viewModel.products.contains{ $0.isFavorite }
    }
    
   
    
    
    var body: some View {
        ScrollView {
            ForEach(viewModel.products.filter({ $0.isFavorite })) {product  in
                
                FavoriteCardView(viewModel: viewModel, product: product)
                
                
            }
        }
    }
}

#Preview {
    FavoriteView(viewModel: ProductViewModel())
}
