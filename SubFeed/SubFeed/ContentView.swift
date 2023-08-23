//
//  ContentView.swift
//  SubFeed
//
//  Created by 김유진 on 2023/08/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            FeedMainView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
