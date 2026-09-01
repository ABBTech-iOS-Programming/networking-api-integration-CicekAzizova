//
//  ProductListView.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

struct ProductListView: View {
    
    @Bindable var viewModel: ProductViewModel
    
    @State  var selectedCategory: String? = nil
    
    @State var searchText: String = ""
    
    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
            } else {
                return viewModel.products.filter {
                    $0.title.localizedCaseInsensitiveContains(searchText) ||
                    ($0.brand?.localizedCaseInsensitiveContains(searchText) ?? false)
            }
        }
    }
  
    private let columns: [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    @ViewBuilder
    var content: some View {
        switch viewModel.state {
        case .idle, .loading:
            ProgressView("Loading...")
        case .loaded:
            productGrid
        case .empty:
            ContentUnavailableView(
                "No product",
                systemImage: "text.page",
                description: Text("There are no products to display")
            )
        case .error(let message):
            ContentUnavailableView {
                Label( " Something went wrong", systemImage: "exclamationmark.triangle") }description: {
                    Text(message)
                }actions: {
                    Button("Try again") {
                        Task {
                            await viewModel.fetchProduct(for: selectedCategory)
                        }
                    }
                }
        }
    }
    
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
            BadgeView(title: "All", horizontalPadding: 22, height: 38, cornerRadius: 19, weight: .inter(.semiBold, size: 12), background: .badge, foreground: .white)
                .onTapGesture {
                    selectedCategory = nil
                    Task {
                        await viewModel.fetchProduct(for: nil)
                    }
                }
            
            ForEach(viewModel.categories, id: \.self){ category in
                let isSelected = selectedCategory == category
                BadgeView(title: category.capitalized, horizontalPadding: 22, height: 38, cornerRadius: 19, weight: .inter(.semiBold, size: 12), background: isSelected ? .badge : .white, foreground: isSelected ? .white : .black)
                    .onTapGesture {
                        selectedCategory = category
                        Task {
                            await viewModel.fetchProduct(for: selectedCategory)
                        }
                    }
                
               
            }
        }
    }
    
    var productGrid: some View {
        LazyVGrid(columns: columns) {
            ForEach(filteredProducts){ product in
                NavigationLink(value: product) {
                    ProductCardView(product: product)
                }
                .buttonStyle(.plain)
               
            }
        }
    }
    
    var body: some View {
            ZStack {
                Color(.homeBackground)
                    .ignoresSafeArea()
                
                VStack {
                    ScrollView {
                        WelcomeBannerCardView()
                            .padding(.bottom,14)
                        searchHolder
                        ScrollView(.horizontal) {
                            allCategory
                                .frame(height: 38)
                            
                        }
                        .scrollIndicators(.hidden)
                        
                        productGrid
                        
                    }
                    
                    .padding(.horizontal, 24)
                }
            }
            .navigationDestination(for: Product.self) { product in
                            if let index = viewModel.products.firstIndex(where: { $0.id == product.id }) {
                                ProductDetailsView(viewModel: viewModel, product: $viewModel.products[index])
                            }
                        }
        
        .task {
            await viewModel.fetchCategories()
            await viewModel.fetchProduct(for: selectedCategory)
            
        }
        .refreshable {
            await viewModel.fetchProduct(for: selectedCategory)
        }
    }
    
        
}

#Preview {
    ProductListView(viewModel: ProductViewModel())
}
