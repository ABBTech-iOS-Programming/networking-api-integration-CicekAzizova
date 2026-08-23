//
//  QuantityView.swift
//  ProductShopApp
//
//  Created by Cicek on 23.08.26.
//

import SwiftUI

struct QuantityView: View {
    let product: Product
    @Binding var quantity: Int
    
    var body: some View {
        
        let bound = 1...min(product.stock, 10)
        
        HStack(spacing: 19) {
            Button {
                if quantity > bound.lowerBound {
                    quantity -= 1
                }
                
            } label: {
                BadgeView(title: "-", horizontalPadding: 16, height: 42, cornerRadius: 12, weight: .inter(.medium, size: 20), background: .quantityButton, foreground: .black)
            }
            
            Text(String(quantity))
            
            Button {
                if quantity < bound.upperBound {
                    quantity += 1
                }
            } label: {
                BadgeView(title: "+", horizontalPadding: 14, height: 42, cornerRadius: 12, weight: .inter(.medium, size: 20), background: .quantityButton, foreground: .black)
            }
            
        }
    }
}

#Preview {
    @Previewable @State var quantity = 1
    QuantityView(product: Product.sample, quantity: $quantity)
}
