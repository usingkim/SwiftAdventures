//
//  ContentView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI

// ContentView에 기능을 다 담지 말고 최소한의 기능만 담아보자

struct ContentView: View {
    var body: some View {
        NavigationStack {
            StickerListView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
