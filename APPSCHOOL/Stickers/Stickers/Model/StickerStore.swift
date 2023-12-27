//
//  StickerStore.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import Foundation
import SwiftUI
// 그릇
class StickerStore: ObservableObject {
    @Published var stickers: [Sticker] = []
    
    init() {
        stickers = [
            Sticker(memo: "Hello", color: .blue, date: Date()),
            Sticker(memo: "Hi", color: .cyan, date: Date()),
            Sticker(memo: "Good Afternoon!", color: .brown, date: Date())
        ]
    }
    
    func addSticker(memo: String, color: Color) {
        let sticker = Sticker(memo: memo, color: color, date: Date())
        stickers.insert(sticker, at:0)
        print(sticker)
    }
    
    func removeSticker(_ sticker: Sticker) {
        var idx = 0
        
        for tempSticker in stickers {
            if tempSticker.id == sticker.id {
                stickers.remove(at: idx)
                break
            }
            idx += 1
        }
    }
}
