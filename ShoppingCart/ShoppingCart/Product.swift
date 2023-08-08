//
//  Product.swift
//  ShoppingCart
//
//  Created by 김유진 on 2023/08/04.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()

    var name: String
    var image: String
    var price: Int
    var shoppingMallName: String
    var shoppingMallLink: URL
}
