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

enum CategoryFilter: String, CaseIterable, Identifiable {
    case all = "All"
    case beauty = "Beauty"
    case fragrances = "Fragrances"
    case furniture = "Furniture"
    case groceries = "Groceries"
    case home = "Home"
    case tech = "Tech"
    case men = "Men"
    case women = "Women"
    case sports = "Sports"
    case vehicles = "Vehicles"
    
    var id: String { rawValue }
    
    var matchingAPICategories: [String] {
        switch self {
        case .all:
            return []
        case .beauty:
            return ["beauty", "skin-care"]
        case .fragrances:
            return ["fragrances"]
        case .furniture:
            return ["furniture"]
        case .groceries:
            return ["groceries"]
        case .home:
            return ["home-decoration", "kitchen-accessories"]
        case .tech:
            return ["smartphones", "laptops", "tablets", "mobile-accessories"]
        case .men:
            return ["mens-shirts", "mens-shoes", "mens-watches"]
        case .women:
            return ["womens-bags", "womens-dresses", "womens-jewellery", "womens-shoes", "womens-watches"]
        case .sports:
            return ["sports-accessories", "sunglasses", "tops"]
        case .vehicles:
            return ["motorcycle", "vehicle"]
        }
    }
}
