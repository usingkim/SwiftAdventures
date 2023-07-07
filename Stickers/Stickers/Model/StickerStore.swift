//
//  StickerStore.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import Foundation
// 그릇
class StickerStore: ObservableObject {
    var stickers: [Sticker] = []
    
    init() {
        stickers = [
            Sticker(memo: "Hello", color: .blue, date: Date()),
            Sticker(memo: "Hi", color: .cyan, date: Date()),
            Sticker(memo: "Good Afternoon!", color: .brown, date: Date())
        ]
    }
}
