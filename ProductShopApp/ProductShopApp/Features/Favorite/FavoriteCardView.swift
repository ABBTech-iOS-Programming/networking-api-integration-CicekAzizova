//
//  FavoriteCardView.swift
//  ProductShopApp
//
//  Created by Cicek on 23.08.26.
//


import SwiftUI
import SDWebImageSwiftUI

struct FavoriteCardView: View {
    
    let viewModel: ProductViewModel
    
    let product: Product
    
    
    var cardView: some View {
        HStack {
            image
            VStack(alignment: .leading,spacing: 6) {
                Text(product.title)
                
                    .font(.inter(.semiBold, size: 13))
                
                Text(product.brand ?? "")
                
                    .font(.inter(.regular, size: 10))
                    .foregroundStyle(.secondary)
                HStack {
                    
                    Text("★")
                    Text(String(format: "%.1f", product.rating))
                        .padding(.trailing, 150)
                    if viewModel.isFavorite {
                        Image(systemName: "heart.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.red)
                            .padding(.horizontal, 24)
                    }
                    
                }
                .foregroundStyle(.rating)
                .font(.inter(.semiBold, size: 10))
                HStack {
                    Text(product.price, format: .currency(code: "USD").presentation(.narrow))
                    
                        .font(.inter(.semiBold, size: 13))
                    Spacer()
                    
                }
                
            }
        }
       
        .frame(height: 212)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .clipped()
        
    }
    
    var image: some View {
      
            WebImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            
            .frame(width: 100, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .clipped()
        
    }
    
    var body: some View {
       cardView
    }
}

#Preview {
    FavoriteCardView(viewModel: ProductViewModel(), product: Product.sample)
}
