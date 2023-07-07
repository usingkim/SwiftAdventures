//
//  Sticker.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import Foundation
import SwiftUI

// memo 내용, color, date
struct Sticker : Identifiable {
    // id value 굳이 만들어주는 이유? Identifier, List
    var id: UUID = UUID()
    var memo: String
    var color: Color
    var date: Date
    
    var dateString: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        return dateFormatter.string(from: date)
    }
}
