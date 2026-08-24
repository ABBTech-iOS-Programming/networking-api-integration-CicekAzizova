//
//  ProductCardView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProductCardView: View {
    
    let product: Product
    
    
    var cardView: some View {
        VStack {
            image
            VStack(alignment: .leading) {
                Text(product.title)
                
                    .font(.inter(.semiBold, size: 13))
                    .padding(.bottom,5)
                
                Text(product.brand ?? "")
                
                    .font(.inter(.regular, size: 10))
                    .foregroundStyle(.secondary)
                HStack {
                    Text(product.price, format: .currency(code: "USD").presentation(.narrow))
                    
                        .font(.inter(.semiBold, size: 13))
                    Spacer()
                    
                    Button {
                        print(" add ")
                    } label: {
                        BadgeView(title: "+", horizontalPadding: 9, height: 30, cornerRadius: 10, weight: .inter(.medium, size: 19), background: .badge, foreground: .white)
                    }

                    
                }
                
            }
            .padding(.top,12)
            .padding(.horizontal,12)
        }
       
        .frame(height: 212)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .clipped()
        
    }
    
    var image: some View {
        ZStack(alignment: .topLeading) {
            WebImage(url: URL(string: product.thumbnail)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            
            .frame(width: 151, height: 108)
            .clipShape(RoundedRectangle(cornerRadius: 14))
            .clipped()
            .padding(.top, 6)
            .padding(.horizontal, 6)

            HStack(spacing: 4) {
                Text("★")
                Text(String(format: "%.1f", product.rating))
            }
            .foregroundStyle(.rating)
            .font(.inter(.semiBold, size: 10))
            .padding(.top, 8)
            .padding(.leading, 6)
        }
        
    }
    
    var body: some View {
       cardView
    }
}

#Preview {
    ProductCardView(product: Product.sample)
}
