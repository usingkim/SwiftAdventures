//
//  Memo.swift
//  YoojinMemoRealTime
//
//  Created by 김유진 on 2023/08/16.
//

import Foundation

struct Memo: Identifiable, Codable {
    var id: String = UUID().uuidString // json으로 바꿔서 집어넣을거라서
    var text: String
    
}
