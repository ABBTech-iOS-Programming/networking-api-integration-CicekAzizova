//
//  ProductMockData.swift
//  ProductShopApp
//
//  Created by Cicek on 21.08.26.
//
import SwiftUI

extension Product {
    static let sample = Product(
        id: 1,
        title: "Essence Mascara Lash Princess",
        description: "The Essence Mascara Lash Princess is a popular mascara known for its volumizing and lengthening effects. Achieve dramatic lashes with this long-lasting and cruelty-free formula.",
        category: "beauty",
        price: 9.99,
        discountPercentage: 7.17,
        rating: 4.94,
        stock: 5,
        brand: "Essence",
        weight: 2,
        reviews: [
            Review(rating: 2),
            Review(rating: 5)
        ],
        thumbnail: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/thumbnail.png",
        images: [
            "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png"
        ]
    )
}
