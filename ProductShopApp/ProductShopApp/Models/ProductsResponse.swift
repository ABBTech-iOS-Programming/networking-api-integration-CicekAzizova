//
//  ProductsResponse.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//
import Foundation

struct ProductsResponse: Decodable {
    let products: [Product]
}

struct Product: Identifiable, Decodable,Hashable {
    let id: Int
    let title: String
    let description: String
    let category: String
    let price: Double
    let discountPercentage: Double
    let rating: Double
    let stock: Int
    let brand: String?
    let weight: Int
    let reviews: [Review]
    let thumbnail: String
    let images: [String]
    var isFavorite: Bool = false
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, category, price, discountPercentage, rating, stock, brand, weight, reviews, thumbnail, images
        }
}

struct Review: Decodable, Hashable {
    let rating: Int
    
}
