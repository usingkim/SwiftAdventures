//
//  ProductListView.swift
//  ShoppingCart
//
//  Created by 김유진 on 2023/08/04.
//

import SwiftUI

struct ProductListView: View {
    
    var cart: Cart
    
    @State var url: URL = URL(string: "https://techit.education")!
    
    @State var isShowingWebsite = false
    
    let productList: [Product] = [
        Product(name: "새우깡", image: "새우깡", price: 2200, shoppingMallName: "G마켓", shoppingMallLink: URL(string: "http://item.gmarket.co.kr/Item?goodscode=1563746615&buyboxtype=ad")!),
        
        Product(name: "hmm", image: "hmm", price: 5555, shoppingMallName: "G마켓", shoppingMallLink: URL(string: "http://item.gmarket.co.kr/Item?goodscode=1563746615&buyboxtype=ad")!)
    ]
    
    var body: some View {
        NavigationStack {
            List(productList) { product in
                
                ProductView(product: product)
                    .swipeActions {
                        Button("장바구니 담기") {
                            cart.addCart(product)
                        }
                        .tint(.cyan)
                    }
            }
            .navigationTitle("Products")
        }
    }
}

struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


