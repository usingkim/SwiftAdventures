//
//  Feed.swift
//  S_nowManCustomer
//
//  Created by 김유진 on 2023/08/25.
//

import Foundation

struct Feed: Identifiable, Codable, Hashable {
    
    var id: String = UUID().uuidString // 자동 생성 값
    var uid: String // 글 작성자 uid
    var username: String // 작성자 이름
    var profileImageURL : String? // 프로필 이미지
    var feedImage : String // <- var image : [UIImage] 변경해야함
    var content: String // 내용
    var createdAt: Double = Date().timeIntervalSince1970
    var like : Int
//    var replies : [Reply]?  ( reply.id )로 접근
//    var organization : String // 나중에 추가 요청.. or not
    
    var isReported : Bool = false //false가 기본값, true면 어떤 사용자가 신고한 적 있는 포스트
    var createdDate: String { // 나중에 추가 요청
        let dateCreatedAt: Date = Date(timeIntervalSince1970: createdAt)
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "MM월 dd일 HH시 mm분"
        
        return dateFormatter.string(from: dateCreatedAt)
    }
}
