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
    
    // loadJson은 가지고 있는 파일을 통해서 load
    // loadJsonInternet은 웹 서버에 있는 파일을 통해서 load 한다.
    
    init() {
        
    }
    
    func fetchProducts() {
//        products = loadJson("products.json")
        Task{
            await loadJsonInternet()
        }
    }
    
    func loadJsonInternet() async {
        let urlString: String = "https://run.mocky.io/v3/9fc18033-9467-419d-a783-5c9e7268a868"
        
        var data: Data
        
        guard let url = URL(string: urlString) else {
            fatalError("URL Error")
            return
        }
        
        do {
            (data, _) = try await URLSession.shared.data(from: url)
            print("\(data)")
        }
        catch {
            debugPrint("url을 찾을 수 없습니다.")
            return
        }
        
        do{
            let jsonString = String(data: data, encoding: .utf8)
            print("\(jsonString ?? "")")
            
            products = try JSONDecoder().decode([Product].self, from: data)
            
            print("\(products)")
        }
        catch {
            debugPrint("변환할 수 없습니다.")
        }
    }
    
    func loadJson(_ filename: String) -> [Product] {
        let data: Data
        
        // 프로젝트의 번들 파일들 중에서
        // 해당 이름의 파일이 존재하는지 확인해서
        // 그 파일이 있다면 file이라는 주소 값에 담고
        // 없다면 에러를 발생시키고 중지한다
        guard let file: URL = Bundle.main.url(forResource: filename, withExtension: nil) else {
            fatalError("\(filename) not found.")
        }
        
        // 존재하는 file 주소에 접근해 그 내용을 읽어서 Data 값으로 만든다
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Could not load \(filename): \(error)")
        }
        
        // 이제 Data 타입의 내용을 JSON이라고 생각해서
        // 원래 우리가 목표로 한 [Product] 타입으로 변환시켜 담아보도록 한다
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            fatalError("Unable to parse \(filename): \(error)")
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
                productStore.fetchProducts()
            }
            .onAppear {
                productStore.fetchProducts()
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
