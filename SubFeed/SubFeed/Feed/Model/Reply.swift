//
//  Reply.swift
//  S_nowManCustomer
//
//  Created by cha_nyeong on 2023/08/24.
//

import Foundation

struct Reply: Identifiable, Codable, Hashable {
    /* MARK: 데이터 구조에 O */
    var id: String = UUID().uuidString
    var username: String
    var content: String
    var createdAt: Double = Date().timeIntervalSince1970
    
    /* MARK: Data 구조에 X */
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
