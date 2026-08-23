//
//  ProductListView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct ProductListView: View {
    
    @Bindable var viewModel: ProductViewModel
    
    @State  var selectedCategory: CategoryFilter = .all
    
    @State var searchText: String = ""
    
    var filteredProducts: [Product] {
    let categoryFiltered = selectedCategory == .all
        ? viewModel.products
        : viewModel.products.filter { selectedCategory.matchingAPICategories.contains($0.category) }
    
    if searchText.isEmpty {
        return categoryFiltered
            } else {
        return categoryFiltered.filter {
            $0.title.contains(searchText) ||
            ($0.brand?.contains(searchText) ?? false)
            }
        }
    }
  
    private let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    
    var searchHolder: some View {
        ZStack(alignment: .topLeading) {
            HStack(alignment: .center) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 16, height: 16)
                    .padding(.leading, 16)
                TextField("Search products", text: $searchText)
                    .font(.inter(.regular, size: 14))
                    .padding(.leading, 20)
                    
                
            }
        }
        .frame(height: 52)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(.bottom,16)
    }
    
    var allCategory: some View {
        LazyHStack {
            ForEach(CategoryFilter.allCases){ category in
                BadgeView(title: category.rawValue, horizontalPadding: 22, height: 38, cornerRadius: 19, weight: .inter(.semiBold, size: 12), background: .badge, foreground: .white)
                    .onTapGesture {
                        selectedCategory = category
                    }
            }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.homeBackground)
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        WelcomeBannerCardView(viewModel: viewModel)
                            .padding(.bottom,14)
                        searchHolder
                        ScrollView(.horizontal) {
                            allCategory
                                .frame(height: 38)
                            
                        }
                        .scrollIndicators(.hidden)
                        
                        LazyVGrid(columns: columns) {
                            ForEach(filteredProducts){ product in
                                NavigationLink(value: product) {
                                    ProductCardView(product: product)
                                }
                                .buttonStyle(.plain)
                               
                            }
                        }
                    }
                    
                    .padding(.horizontal, 24)
                }
            }
            
            .navigationDestination(for: Product.self) { product in
                            if let index = viewModel.products.firstIndex(where: { $0.id == product.id }) {
                                ProductDetailsView(viewModel: viewModel, product: $viewModel.products[index])
                            }
                        }
        }
        .task {
            await viewModel.fetchProduct()
        }
    }
    
        
}

#Preview {
    ProductListView(viewModel: ProductViewModel(), selectedCategory: CategoryFilter.all)
}
