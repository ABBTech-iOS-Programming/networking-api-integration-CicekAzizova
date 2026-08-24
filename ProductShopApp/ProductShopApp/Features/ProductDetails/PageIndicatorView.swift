//
//  PageIndicatorView.swift
//  ProductShopApp
//
//  Created by Cicek on 24.08.26.
//

import SwiftUI

struct PageIndicatorView: View {
    
    let totalImage: Int
    let currentImage: Int
    
    var body: some View {
        
        
        HStack {
            ForEach(0..<totalImage,id: \.self){ index in
                Capsule()
                    .fill(index == currentImage ? Color.badge : Color.gray.opacity(0.3) )
                    .frame(width: index == currentImage ? 18 : 5, height: 5)
                    .animation(.easeInOut(duration: 0.2),value: currentImage)
                    
            }
        }
    }
}

#Preview {
    PageIndicatorView(totalImage: 3, currentImage: 1)
}
