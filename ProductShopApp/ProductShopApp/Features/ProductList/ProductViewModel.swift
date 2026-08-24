//
//  ProductViewModel.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//

import SwiftUI

@Observable
final class ProductViewModel {
    var products: [Product] = []
    
    var state: ProductsViewState = .idle
    
    var isFavorite: Bool = false
    
    let defaults = UserDefaults.standard
    
    private enum Key {
        static let isFavorite = "isFavorite"
    }
    
    
    
    private let urlString: String = "https://dummyjson.com/products?limit=194"
    
    func fetchProduct() async {
        state = .loading
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
            
            state = productResponse.products.isEmpty ? .empty : .loaded
           
            
        }catch {
            print("Decode error: \(error)")

        }
    }
    
    func saveFavorite() {
        defaults.set(isFavorite, forKey: Key.isFavorite)
        }
    
    func loadFavorite() {
       isFavorite =  defaults.bool(forKey: Key.isFavorite)
    }
}
