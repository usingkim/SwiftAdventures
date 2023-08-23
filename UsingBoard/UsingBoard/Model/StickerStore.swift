//
//  StickerStore.swift
//  UsingBoard
//
//  Created by 김유진 on 2023/08/18.
//

import Foundation

class StickerStore: ObservableObject {
    @Published var stickers: [Sticker] = []
    
    func fetchStickers() {
        stickers = [
            Sticker(memo: "Hello World", colorIdx:  0, createdAt: Date().timeIntervalSince1970),
            Sticker(memo: "안녕하세요", colorIdx:  2, createdAt: Date().timeIntervalSince1970)
        ]
    }
    
    func addSticker(_ sticker: Sticker) {
        stickers.append(sticker)
    }
    
    func removeSticker(_ sticker: Sticker) {
        let stickerId = sticker.id
        var index: Int = 0
        
        for tempSticker in stickers {
            if tempSticker.id == stickerId{
                stickers.remove(at: index)
                break
            }
            
            index += 1
        }
    }
    
    // for preview
    var sampleSticker: Sticker {
        Sticker(memo: "Hello World", colorIdx:  0, createdAt: Date().timeIntervalSince1970)
    }
}
