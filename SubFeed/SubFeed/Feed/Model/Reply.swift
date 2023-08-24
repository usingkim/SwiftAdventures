//
//  Reply.swift
//  SubFeed
//
//  Created by dayexx on 2023/08/24.
//

import Foundation

struct Reply: Identifiable {
    var id: String = UUID().uuidString
    var username: String
    var text: String
    var createdAt: Double = Date().timeIntervalSince1970
    var imageString : String
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}
