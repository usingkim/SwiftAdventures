//
//  CartView.swift
//  ShoppingCart
//
//  Created by 김유진 on 2023/08/04.
//

import SwiftUI
import SafariServices


struct CartView: View {
    @State var url: URL = URL(string: "https://techit.education")!
    
    var cart: Cart
    
    var body: some View {
        NavigationStack {
            List(cart.products) { product in
                HStack {
                    Button {
                        url = product.shoppingMallLink
//                        isShowingWebsite.toggle()
                        
                    } label: {
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
                .swipeActions {
                            Button("장바구니 담기") {
                                print("Right on!")
                            }
                            .tint(.cyan)
                        }
            }
            .navigationTitle("Products")
        }
//        .sheet(isPresented: $isShowingWebsite) {
//            SafariView(url: $url)
//            //                .presentationDetents([.medium, .large])
//        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SafariView: UIViewControllerRepresentable {
    @Binding var url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
