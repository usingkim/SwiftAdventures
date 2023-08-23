//
//  ContentView.swift
//  UsingBoard
//
//  Created by 김유진 on 2023/08/18.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            StickerListView()
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
