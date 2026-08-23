//
//  MainTabView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct MainTabView: View {
    
    @State private var viewModel = ProductViewModel()
    
    var body: some View {
        TabView {
            
            
            Tab {
                NavigationStack {
                    ProductListView(viewModel: viewModel)
                }
            } label: {
                Image(.home)
                    .renderingMode(.template)
                    .foregroundStyle(.tabBar)
                    
            }
            
            Tab {
                FavoriteView(viewModel: viewModel)
            } label: {
                Image(.heart)
                    
            }
            
            Tab {
                
            } label: {
                Image(.square)
                    
            }
            
            Tab {
                
            } label: {
                Image(.circle)
                    
            }

        }
        .tint(.badge)
        .refreshable {
            await viewModel.fetchProduct()
        }
    }
}

#Preview {
    MainTabView()
}
