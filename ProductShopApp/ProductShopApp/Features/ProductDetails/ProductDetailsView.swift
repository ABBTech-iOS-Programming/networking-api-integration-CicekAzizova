//
//  ProductDetailsView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct ProductDetailsView: View {

    @Binding var product: Product
    
    var image: some View {
        VStack {
            AsyncImage(url: URL(string: product.thumbnail)){ image in
                image
                    .resizable()
                    .scaledToFill()
                
            }placeholder: {
                ProgressView()
            }
            .frame(width: 342,height: 258)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .clipped()
            
            Circle()
                .frame(width: 5,height: 5)
        }
    }
    
    var stockBadgeView: some View {
        Text("In Stock: \(product.stock)")
            .lineLimit(1)
            .padding(.vertical, 7)
            .padding(.horizontal, 16)
            .background(.stockBadge)
            
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .clipped()
    }
    
   
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading) {
                image
                
                Text(product.title)
                    .font(.inter(.bold, size: 20))
                HStack {
                    Text(product.category.capitalized)
                    Text(product.brand ?? "")
                }
                .font(.inter(.medium, size: 12))
                .foregroundStyle(.tabBar)
                
                HStack {
                    
                    Text("★")
                        .foregroundStyle(.rating)
                        .font(.inter(.semiBold, size: 14))
                    Text(String(format: "%.1f", product.rating))
                        .foregroundStyle(.rating)
                        .font(.inter(.semiBold, size: 14))
                    
                    Text("(\(product.reviews.count) reviews)")
                        .foregroundStyle(.tabBar)
                        .font(.inter(.regular, size: 11))
                        
                    Spacer()
                    BadgeView(title: "In Stock: \(product.stock)", horizontalPadding: 26, height: 28, cornerRadius: 14, weight: .inter(.semiBold, size: 11), background: .stockBadge, foreground: .stockText)
                }
                .padding(.bottom,19)
                
                Rectangle()
                    .frame(height: 1)
                    .foregroundStyle(.line)
                    
                
                Text("Description")
                    .font(.inter(.semiBold, size: 15))
                    .padding(.bottom,10)
                
                Text(product.description)
                    .font(.inter(.regular, size: 12))
                    .padding(.bottom,30)
                Text("Quantity")
                    .font(.inter(.semiBold, size: 14))
                    .padding(.bottom,14)
                
                    .padding(.top, 8)
                    .padding(.leading, 6)
                
                HStack(spacing: 19) {
                    Button {
                        
                    } label: {
                        BadgeView(title: "-", horizontalPadding: 16, height: 42, cornerRadius: 12, weight: .inter(.medium, size: 20), background: .quantityButton, foreground: .black)
                    }
                    
                    Text("1")
                    
                    Button {
                        
                    } label: {
                        BadgeView(title: "+", horizontalPadding: 14, height: 42, cornerRadius: 12, weight: .inter(.medium, size: 20), background: .quantityButton, foreground: .black)
                    }
                    
                }
                .padding(.bottom,25)
                HStack {
                    VStack(alignment: .leading) {
                        Text("Price")
                            .font(.inter(.regular, size: 11))
                            .foregroundStyle(.tabBar)
                            .padding(.bottom,6)
                        
                        Text(product.price, format: .currency(code: "USD").presentation(.narrow))
                    }
                    Spacer()
                    BadgeView(title: "Add to Cart", horizontalPadding: 69, height: 58, cornerRadius: 18, weight: .inter(.semiBold, size: 15), background: .badge, foreground: .white)
                }
            }
            .padding(.horizontal,24)
            .navigationTitle("Product Details")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                   
                    Button {
                        product.isFavorite.toggle()
                    } label: {
                        Image(systemName: product.isFavorite ? "heart.fill" : "heart")
                            .foregroundStyle(product.isFavorite ? .red : .primary)
                        
                    }
                    
                }
            }
        }
    }
        
}

#Preview {
    @Previewable @State var product = Product.sample
    NavigationStack {
        ProductDetailsView(product: $product)
    }
}
