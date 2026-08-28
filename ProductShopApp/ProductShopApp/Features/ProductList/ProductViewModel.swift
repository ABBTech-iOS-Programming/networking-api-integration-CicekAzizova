//
//  ProductViewModel.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

@MainActor
@Observable
final class ProductViewModel {
    var products: [Product] = []
    
    var categories: [String] = []
    
    var state: ProductsViewState = .idle
    
    
    private enum Key {
        static let isFavorite = "isFavorite"
    }
    
    private var favoriteIds: [Int] {
        get {
            UserDefaults.standard.array(forKey: Key.isFavorite) as? [Int] ?? []
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Key.isFavorite)
        }
    }
    
    func loadItems() {
        let savedSet = Set(favoriteIds)
        
        for i in products.indices {
            if savedSet.contains(products[i].id){
                products[i].isFavorite = true
            }
        }
    }
    
    func toggleFavorite(for itemId: Int) {
        guard let index = products.firstIndex(where: { $0.id == itemId }) else { return }
        products[index].isFavorite.toggle()
        
        if products[index].isFavorite {
            favoriteIds.insert(itemId, at: 0)
        }else {
            favoriteIds.removeAll { $0 == itemId }
        }
    }
    
    func fetchCategories() async {
        let urlString = "https://dummyjson.com/products/category-list"
        
        guard let url = URL(string: urlString) else { return }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            categories = try JSONDecoder().decode([String].self, from: data)
        } catch  {
            print("Category fetch error: \(error)")
        }
    }
    
    
    func fetchProduct(for category: String?) async {
        state = .loading
        
        let urlString = category.map({"https://dummyjson.com/products/category/\($0)"}) ?? "https://dummyjson.com/products?limit=194"
        
        guard let url = URL(string: urlString) else {
            state = .error("Invalid Url")
            return
        }
        
        var requrest = URLRequest(url: url)
        requrest.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: requrest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                state = .error("Invalid response")
               
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                state = .error("Error \(httpResponse.statusCode)")
              
                return
            }
            
            let decoder = JSONDecoder()
            
           let productResponse = try decoder.decode(ProductsResponse.self, from: data)
            
            products = productResponse.products
            
            loadItems()
            
            state = productResponse.products.isEmpty ? .empty : .loaded
           
            
        }catch {
            state = .error("Decode error: \(error.localizedDescription)")
           

        }
    }
    
    
}
