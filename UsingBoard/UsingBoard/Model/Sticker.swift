//
//  Sticker.swift
//  UsingBoard
//
//  Created by 김유진 on 2023/08/18.
//

import Foundation
import SwiftUI

struct Sticker: Identifiable {
    var id: String = UUID().uuidString // FireStore에 String 값으로 집어넣기 위함
    var username: String = "using"
    var memo: String
    var colorIdx: Int
    var createdAt: Double
    
    var color: Color {
        switch colorIdx {
        case 0:
            return .cyan
        case 1:
            return .purple
        case 2:
            return .blue
        case 3:
            return .yellow
        case 4:
            return .brown
        default:
            return .white
        }
    }
    
    var createdDate: String {
        let dateCreatedAt = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
    
    
    var textForSharing: String {
        return "\(memo)\n\(username)\n\(createdDate)"
    }
}
