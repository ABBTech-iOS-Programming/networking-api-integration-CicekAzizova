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
    
    private let urlString: String = "https://dummyjson.com/products?limit=194"
    
    func fetchProduct() async {
        guard let url = URL(string: urlString) else {
            print("Invalid Url")
            return
        }
        
        var requrest = URLRequest(url: url)
        requrest.httpMethod = "GET"
        do {
            let (data, response) = try await URLSession.shared.data(for: requrest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                print("Error \(httpResponse.statusCode)")
                return
            }
            
            let decoder = JSONDecoder()
            
           let productResponse = try decoder.decode(ProductsResponse.self, from: data)
            
            products = productResponse.products
           
            
        }catch {
            print("Decode error: \(error)")

        }
    }
}
