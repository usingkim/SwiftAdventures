//
//  Feed.swift
//
//  Created by dayexx on 2023/08/22.
//

//import Foundation
import SwiftUI

struct Post : Identifiable {
    var id : UUID = UUID()
    var userName : String
    var userImage : String // 어떤식으로 이미지 넣는지 보고 수정
    var organization : String
    var image : [UIImage] // 얘도 보고 수정
    var letter : String
    var like : Int
    var isReported : Bool = false //false가 기본값, true면 어떤 사용자가 신고한 적 있는 포스트

    var createdAt: Double = Date().timeIntervalSince1970
    var createdDate: String {
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}
