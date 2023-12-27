//
//  Cart.swift
//  ShoppingCart
//
//  Created by 김유진 on 2023/08/04.
//

import Foundation

class Cart: ObservableObject {
    @Published var products: [Product]
    
    init() {
        products = []
    }
    
    func addCart(_ p: Product) {
        products.append(p)
    }
    
    func deleteProduct(_ p: Product){
//        self.products.remove(p)
    }
    
}
