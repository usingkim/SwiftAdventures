//
//  ProductView.swift
//  ShoppingCart
//
//  Created by 김유진 on 2023/08/04.
//

import SwiftUI

struct ProductView: View {
    @State var product: Product
    
    var body: some View {
        HStack{
            Image(product.image)
                .resizable(resizingMode: .stretch)
                .frame(width: 200, height: 200)
            Spacer()
            VStack{
                Spacer()
                Text(product.shoppingMallName)
                    .bold()

                Text(product.name)
                Spacer()
                Text("\(product.price)")
                Spacer()
                
            }
            .padding()
        }
    }
}

//struct ProductView_Previews: PreviewProvider {
//    static var previews: some View {
////        ProductView()
//    }
//}
