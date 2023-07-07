//
//  StickerView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI

// 오직 스티커 하나만을 위한 View

struct StickerView: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Sticker")
                    .font(.title)
                    .padding()
                
                Text("2023-07-07")
                    .font(.footnote)
                    .padding()
            }
            Spacer()
        }
        .background(.yellow)
        .shadow(radius: 6)
        .padding()
    }
}

struct StickerView_Previews: PreviewProvider {
    static var previews: some View {
        StickerView()
    }
}
