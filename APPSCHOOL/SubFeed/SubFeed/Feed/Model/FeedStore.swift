//
//  FeedStore.swift
//  S_nowManCustomer
//
//  Created by 김유진 on 2023/08/25.
//

import Foundation
import FirebaseFirestore

class FeedStore: ObservableObject {
    @Published var feeds: [Feed] = []
    let dbRef = Firestore.firestore().collection("Feeds")
    
    func fetchFeeds() {
        
        dbRef.getDocuments { (snapshot, error) in
            self.feeds.removeAll()
            
            if let snapshot {
                var tempFeed: [Feed] = []
                
                for document in snapshot.documents {
                    let id: String = document.documentID
                    let docData: [String : Any] = document.data()
                    
                    let uid: String = docData["uid"] as? String ?? ""
                    let username: String = docData["username"] as? String ?? ""
                    let profileImageURL : String  = docData["profileImageURL"] as? String ?? "duck"
                    let feedImage: String = docData["feedImage"] as? String ?? ""
                    let content : String = docData["content"] as? String ?? ""
                    let like : Int = docData["like"] as? Int ?? 0
                    let createdAt: Double = docData["createdAt"] as? Double ?? 0
                    //let report : String = docData["report"] as? String ?? ""
                    let feed = Feed(id : id, uid: uid, username: username, profileImageURL : profileImageURL, feedImage: feedImage, content: content, createdAt: createdAt, like: like)
                    
                    tempFeed.append(feed)
                }
                
                self.feeds = tempFeed
            }
        }
    }
    
    func addFeed(_ feed : Feed) {
        dbRef.document(feed.id)
            .setData(["username": feed.username,
                      "content": feed.content,
                      "profileImageURL" : feed.profileImageURL ?? "",
                      "createdAt": feed.createdAt,
                      "feedImage" : feed.feedImage
                     ])
        
        fetchFeeds()
    }
    
    func removeFeed(_ feed : Feed) {
        dbRef.document(feed.id).delete()
        fetchFeeds()
    }
    
    func reviseFeed(_ feed : Feed, _ letter : String, _ feedImage: String) {
        dbRef.document(feed.id)
            .setData([
                "username": feed.username,
                "profileImageURL" : feed.profileImageURL!,
                "content": letter,
                "createdAt": feed.createdAt,
                "feedImage" : feedImage,
                "like" : feed.like
            ])
        
        fetchFeeds()
    }
    
    func likeFeed(_ feed : Feed) { //좋아요
        dbRef.document(feed.id)
            .setData([
                "username": feed.username,
                "profileImageURL" : feed.profileImageURL!,
                "content": feed.content,
                "createdAt": feed.createdAt,
                "feedImage" : feed.feedImage,
                "like" : feed.like+1
            ])
        fetchFeeds()
    }
    
    func unlikeFeed(_ feed: Feed) { // 좋아요 취소
        var tempLike: Int {
            if(feed.like > 0) {return feed.like - 1}
            else {return 0}
        }
        dbRef.document(feed.id)
            .setData([
                "username": feed.username,
                "profileImageURL" : feed.profileImageURL!,
                "content": feed.content,
                "createdAt": feed.createdAt,
                "feedImage" : feed.feedImage,
                "like" : feed.like-1
            ])
        
        fetchFeeds()
    }
    /*
     func reportFeed(_ feed : Feed){ //신고
     var index: Int = 0
     
     for tempFeed in feeds {
     if tempFeed.id == feed.id {
     feeds[index].isReported = true
     break
     }
     index += 1
     }
     }
     */
    func sharingFeed(feed : String)-> String {
        feed
    }
}
