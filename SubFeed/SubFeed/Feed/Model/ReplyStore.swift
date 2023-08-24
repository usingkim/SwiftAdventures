//
//  ReplyStore.swift
//  SubFeed
//
//  Created by dayexx on 2023/08/24.
//

import Foundation


class ReplyStore: ObservableObject {
    @Published var replies: [Reply] = []
    
    init(){
        replies = [
            Reply(username: "오리", text: "멋져", imageString: "duck"),
            Reply(username: "오리", text: "ㅇㅈ", imageString: "duck"),
            Reply(username: "오리", text: "WOW", imageString: "duck")
        ]
    }
    func addReply(_ reply: Reply) {
        replies.append(reply)
    }
    
    func deleteReply(at offsets: IndexSet){
        replies.remove(atOffsets: offsets)
    }
}
