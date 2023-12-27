//
//  StickerCellView.swift
//  UsingBoard
//
//  Created by 김유진 on 2023/08/18.
//

import SwiftUI

struct StickerCellView: View {
    var sticker: Sticker
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(sticker.memo)
                .padding()
            HStack {
                Text(sticker.username)
                    .font(.caption)
            }
        }
        .background(sticker.color)
        .padding()
    }
}

struct StickerCellView_Previews: PreviewProvider {
    @State static var sticker = StickerStore().sampleSticker
    
    static var previews: some View {
        Group {
            StickerCellView(sticker: sticker)
        }
        .previewLayout(.fixed(width: 400, height: 200))
    }
}
