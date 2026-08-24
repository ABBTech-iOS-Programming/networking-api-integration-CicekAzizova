//
//  ProductDetailsView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductDetailsView: View {
    
    @Bindable var viewModel: ProductViewModel

    @Binding var product: Product
    
    @State var currentImage: Int = 0
    
    var image: some View {
        VStack {
            TabView(selection: $currentImage) {
                ForEach(product.images.indices,id: \.self) {index in
                    WebImage(url: URL(string: product.images[index])){ image in
                        image
                            .resizable()
                            .scaledToFill()
                        
                    }placeholder: {
                        ProgressView()
                    }
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(width: 342,height: 258)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .clipped()
                
            PageIndicatorView(totalImage: product.images.count, currentImage: currentImage)
                
            
        }
    }
    
    @State var quantity: Int = 1
    
    var discount: Double {
        (100 - product.discountPercentage) / 100
    }
    
    
     var totalPrice: Double {
         product.price * Double(quantity) * discount
    }
    
    var price: some View {
        VStack(alignment: .leading) {
            Text("Price")
                .font(.inter(.regular, size: 11))
                .foregroundStyle(.tabBar)
                
                
            
            Text(totalPrice, format: .currency(code: "USD").presentation(.narrow))
                .foregroundStyle(.badge)
                .font(.inter(.bold, size: 24))
                
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
                
                QuantityView(product: product, quantity: $quantity)
                .padding(.bottom,25)
                
                    price
                
                 
            }
            .overlay(alignment: .bottomTrailing) {
                Button {
                    print(" add to card")
                } label: {
                    Text("Add to Cart")
                        .foregroundStyle(.white)
                        .font(.inter(.semiBold, size: 15))
                        .frame(width: 212,height: 58)
                        .background(.badge)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                }
            }
            .padding(.horizontal,24)
            .navigationTitle("Product Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                   
                    Button {
                        product.isFavorite.toggle()
                        viewModel.saveFavorite()
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
        ProductDetailsView(viewModel: ProductViewModel(), product: $product)
    }
}
