//
//  ContentView.swift
//  ShoppingCart
//
//  Created by 김유진 on 2023/08/04.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cart: Cart = Cart()
    
    var body: some View {
        TabView {
            ProductListView(cart: cart).tabItem { Text("품목") }.tag(1)
            CartView(cart: cart).tabItem { Text("장바구니") }.tag(2)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
