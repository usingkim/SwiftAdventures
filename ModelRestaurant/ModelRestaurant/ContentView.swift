//
//  ContentView.swift
//  ModelRestaurant
//
//  Created by 김유진 on 2023/08/08.
//

import SwiftUI

struct Restaurant: Identifiable {
    // 업태 (한식 이런거), 업소명, 도로명주소, 주메뉴
    var id: UUID = UUID()
    var occupation: String
    var name: String
    var address: String
    var menu: String
}

class RestaurantStore: ObservableObject {
    @Published var restaurants: [Restaurant] = []
    
    func fetchRestaurants() async {
        
        let key = "onlGIkGMHENrMtmK%2BT0beq8d4qEbIwXSE8x5wIMSg57O5%2FgJjUfY%2BpWb7ra3Rmmo1T%2FciTphPU9%2F0p3%2FifW15w%3D%3"
        
        let urlString = "http://apis.data.go.kr/6260000/BusanTblFnrstrnStusService/getTblFnrstrnStusInfo?serviceKey=\(key)"
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            print("\(response)")
            
            let jsonString = String(data: data, encoding: .utf8)
            print("\(jsonString ?? "")")
            
            restaurants = try JSONDecoder().decode([Restaurant].self, from: data)
            
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

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
