//
//  StickerListView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI


struct StickerListView: View {
    var body: some View {
        VStack{
            List{
                StickerView()
            }
            .listStyle(.plain)
        }
        .navigationTitle("Stickers")
    }
}

struct StickerListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            StickerListView()
        }
    }
}
