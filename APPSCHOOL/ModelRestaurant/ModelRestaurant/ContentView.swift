//
//  ContentView.swift
//  ModelRestaurant
//
//  Created by 김유진 on 2023/08/08.
//

import SwiftUI

struct Restaurant: Identifiable, Codable {
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
        
        let key = "onlGIkGMHENrMtmK+T0beq8d4qEbIwXSE8x5wIMSg57O5/gJjUfY+pWb7ra3Rmmo1T/ciTphPU9/0p3/ifW15w=="
        
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
            
        } catch {
            debugPrint("--------")
            debugPrint("Error loading \(url):")
            debugPrint("\(String(describing: error))")
            debugPrint("--------")
            
        }
    }
}

struct ContentView: View {
    var restaurantsStore = RestaurantStore()
    
    var body: some View {
        List {
            ForEach(restaurantsStore.restaurants) { restaurant in
                Text("\(restaurant.name)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
