//
//  ContentView.swift
//  Cart
//
//  Created by Jongwook Park on 2023/08/07.
//

import SwiftUI
import SafariServices

extension Double {
    var currencyString: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "KRW"
        return formatter.string(from: NSNumber(value: self)) ?? ""
    }
}

struct Product: Identifiable, Codable {
    var id: String
    var name: String
    var price: Double
    var imageURLString: String
    var shopURLString: String
    
    var priceString: String {
        price.currencyString
    }
    
    var imageURL: URL {
        URL(string: imageURLString) ?? URL(string: "https://apple.com")!
    }
    
    var shopURL: URL {
        URL(string: shopURLString) ?? URL(string: "https://apple.com")!
    }
}


class ProductStore: ObservableObject {
    @Published var products: [Product] = []
    @Published var fetchMessage: String = ""
    
    init() {
        
    }
    
    func fetchProducts() async {
        
        // https://mocki.io/v1/7ea06a18-7972-402e-8123-afe57a433d49
        // https://run.mocky.io/v3/c3cf8d7c-ef6a-4876-8bb1-5f82f53d6805
        
        let urlString: String = "https://mocki.io/v1/7ea06a18-7972-402e-8123-afe57a433d49"
        
        guard let url = URL(string: urlString) else {
            print("Wrong URL")
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            print("\(response)")
            
            let jsonString = String(data: data, encoding: .utf8)
            print("\(jsonString ?? "")")
            
            products = try JSONDecoder().decode([Product].self, from: data)
            
            fetchMessage = ""
        } catch {
            debugPrint("--------")
            debugPrint("Error loading \(url):")
            debugPrint("\(String(describing: error))")
            debugPrint("--------")
            
            fetchMessage = "상품정보 읽기 실패했습니다"
        }
    }
    
}

class CartStore: ObservableObject {
    @Published var products: [Product] = []
    
    func addProduct(_ product: Product) {
        products.append(product)
    }
    
    func removeProducts(at offsets: IndexSet) {
        products.remove(atOffsets: offsets)
    }
}

struct SafariView: UIViewControllerRepresentable {
    @Binding var url: URL
    
    func makeUIViewController(context: Context) -> some UIViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        // ...
    }
}

struct AddingProductView: View {
    var cartStore: CartStore
    @Binding var isShowingAdding: Bool
    
    @ObservedObject private var productStore: ProductStore = ProductStore()
    
    var body: some View {
        NavigationStack {
            VStack {
                if !productStore.fetchMessage.isEmpty {
                    Text("\(productStore.fetchMessage)")
                }
                
                List(productStore.products) { product in
                    VStack(alignment: .leading) {
                        AsyncImage(url: product.imageURL) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        HStack {
                            VStack(alignment: .leading) {
                                Text("\(product.name)")
                                    .font(.headline)
                                Text("\(product.priceString)")
                            }
                            Spacer()
                            Button("Add") {
                                cartStore.addProduct(product)
                                isShowingAdding.toggle()
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .listStyle(.plain)
                .navigationTitle("Add your product")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            isShowingAdding.toggle()
                        }
                    }
                }
                .refreshable {
                    Task {
                        await productStore.fetchProducts()
                    }
                }
                .onAppear {
                    Task {
                        await productStore.fetchProducts()
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    @ObservedObject var cartStore: CartStore = CartStore()
    
    @State private var isShowingAdding: Bool = false
    @State private var isShowingShop: Bool = false
    @State private var shopURL: URL = URL(string: "https://apple.com")!
    
    private var isCartEmpty: Bool {
        return cartStore.products.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if isCartEmpty {
                    VStack(alignment: .center) {
                        Image(systemName: "questionmark.square.dashed")
                            .font(.largeTitle)
                        Text("Cart is empty.")
                        Text("Please add your products!")
                    }
                }
                
                List {
                    ForEach(cartStore.products) { product in
                        HStack {
                            AsyncImage(url: product.imageURL) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 150)
                            } placeholder: {
                                ProgressView()
                            }
                            
                            VStack(alignment: .leading) {
                                Text("\(product.name)")
                                    .font(.headline)
                                Text("\(product.priceString)")
                            }
                            
                            Spacer()
                            
                            Button("Buy") {
                                shopURL = product.shopURL
                                isShowingShop.toggle()
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                    .onDelete { offsets in
                        cartStore.removeProducts(at: offsets)
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add") {
                        isShowingAdding.toggle()
                    }
                }
            }
            .sheet(isPresented: $isShowingAdding) {
                AddingProductView(cartStore: cartStore, isShowingAdding: $isShowingAdding)
            }
            .sheet(isPresented: $isShowingShop) {
                SafariView(url: $shopURL)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
