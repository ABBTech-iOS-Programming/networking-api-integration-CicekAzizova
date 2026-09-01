//
//  BadgeView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct BadgeView: View {
    let title: String
    let horizontalPadding: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let weight: Font
    let background: Color
    let foreground: Color
    
    var body: some View {
        Text(title)
            .foregroundStyle(foreground)
            .lineLimit(1)
            .font(weight)
            .padding(.horizontal,horizontalPadding)
            .frame(height: height)
            .background(background)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        
    }
        
}

#Preview {
    BadgeView(title: "20 % OFF", horizontalPadding: 13, height: 28, cornerRadius: 14, weight: .inter(.semiBold, size: 12), background: .badge, foreground: .white)
}
