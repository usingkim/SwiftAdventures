//
//  ReplyStore.swift
//  S_nowManCustomer
//
//  Created by cha_nyeong on 2023/08/24.
//

import Foundation
import FirebaseFirestore

class ReplyStore: ObservableObject {
    @Published var replies: [Reply] = []
    
    let dbRef = Firestore.firestore().collection("Feeds")
    var feedId: String = ""

    func fetchReplies() {
        
        dbRef.document(feedId).collection("Replies").getDocuments { (snapshot, error) in
            self.replies.removeAll()
            
            if let snapshot {
                var tempReplies: [Reply] = []
                
                for document in snapshot.documents {
                    let id: String = document.documentID
                    
                    let docData: [String : Any] = document.data()
                    let username: String = docData["username"] as? String ?? "오리"
                    let content: String = docData["content"] as? String ?? ""
                    let createdAt: Double = docData["createdAt"] as? Double ?? 0
                    let imageString: String = docData["imageString"] as? String ?? ""
                    
                    let reply = Reply(id: id, username: username, content: content, createdAt: createdAt, imageString: imageString)
                    
                    tempReplies.append(reply)
                }
                
                self.replies = tempReplies
            }
        }
    }
    func addReply(_ reply: Reply) {
        dbRef.document(feedId).collection("Replies")
            .document(reply.id)
            .setData(["username": reply.username,
                      "content": reply.content,
                      "createdAt": reply.createdAt,
                      "imageString" : reply.imageString
                     ])
        
        fetchReplies()
    }
    
    func deleteReply(_ reply: Reply){
        dbRef.document(reply.id).delete()
        fetchReplies()
    }
}
