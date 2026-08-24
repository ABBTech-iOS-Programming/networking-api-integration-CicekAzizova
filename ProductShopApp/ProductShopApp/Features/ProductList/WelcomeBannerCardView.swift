//
//  WelcomeBannerCardView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct WelcomeBannerCardView: View {
  
    var cardView: some View {
        VStack(alignment: .leading,spacing: 7){
            HStack {
                greeting
                Spacer()
                BadgeView( title: "20% OFF", horizontalPadding: 12, height: 28, cornerRadius: 14, weight: .inter(.semiBold, size: 12), background: .badge, foreground: .black)
                    .padding(.trailing,20)

            }
            title
            subtitle
          
            
        }
        .padding(.leading,18)
        
        .frame(height: 128)
        .background(.welcomeCard)
        .clipShape(RoundedRectangle(cornerRadius: 22))
  
    }
    
    var greeting: some View {
        Text("Good morning")
            .font(.inter(.regular, size: 12))
            .foregroundStyle(.greeting)
    }
    
    var title: some View {
        Text("Find your next favorite product")
            .font(.inter(.bold, size: 22))
            .foregroundStyle(.white)
    }
    
    var subtitle: some View {
        Text("Fresh picks for you")
            .font(.inter(.medium, size: 12))
            .foregroundStyle(.subtitle)
    }
    var body: some View {
        cardView
    }
}

#Preview {
    WelcomeBannerCardView()
}
