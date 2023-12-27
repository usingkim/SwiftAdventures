//
//  StickerView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI

// 오직 스티커 하나만을 위한 View

struct StickerView: View {
    let sticker: Sticker
    var stickerStore: StickerStore
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(sticker.memo)")
                    .font(.title)
                    .padding()
                
                Text("\(sticker.dateString)")
                    .font(.footnote)
                    .padding()
            }
            Spacer()
        }
        .background(sticker.color)
        .shadow(radius: 6)
        .padding()
        .contextMenu { // 꾹 누르면
            Button {
                stickerStore.removeSticker(sticker)
            } label: {
                Image(systemName: "trash.slash")
                Text("Remove")
            }

        }
    }
}

struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        StickerView(sticker: Sticker(memo: "he", color: .red, date: Date()), stickerStore: StickerStore())
    }
}
