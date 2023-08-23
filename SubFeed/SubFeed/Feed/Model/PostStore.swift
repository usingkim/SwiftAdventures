//
//  PostStore.swift
//  S_nowManCustomer
//
//  Created by dayexx on 2023/08/22.
//
import SwiftUI

class PostStore : ObservableObject{
    @Published var posts: [Post] = []
    
    init(){
        posts = [
            Post(userName: "오리", userImage: "duck", organization: "멋쟁이사자", image: [UIImage(named: "sin") ?? UIImage(), UIImage(named: "sin") ?? UIImage()], letter: "자고싶다", like: 3),
            Post(userName: "오리", userImage: "duck", organization: "구글", image: [UIImage(named: "sin") ?? UIImage()], letter: "집가고싶다", like: 10),
            Post(userName: "오리", userImage: "duck", organization: "토스", image: [UIImage(named: "sin") ?? UIImage()], letter: "자고싶다", like: 100),
            Post(userName: "오리", userImage: "duck", organization: "네이버", image: [UIImage(named: "sin") ?? UIImage()], letter: "집가고싶다", like: 999)
        ]
    }
    func addPost(_ post : Post) {
        posts.insert(post, at:0)
    }
    func removePost(_ post : Post) {
        var index: Int = 0
        
        for tempPost in posts {
            
            if tempPost.id == post.id {
                posts.remove(at: index)
                break
            }
            
            index += 1
        }
    }
    func revisePost(_ post : Post, _ letter : String) {
        var index: Int = 0
        
        for tempPost in posts {
            if tempPost.id == post.id {
                posts[index].letter = letter
                break
            }
            index += 1
        }
    }
    
    func likePost(_ post : Post) { //좋아요
        var index: Int = 0
        
        for tempPost in posts {
            if tempPost.id == post.id {
                posts[index].like += 1
                break
            }
            index += 1
        }
        
    }
    
    func reportPost(_ post : Post){ //신고
        var index: Int = 0
        
        for tempPost in posts {
            if tempPost.id == post.id {
                posts[index].isReported = true
                break
            }
            index += 1
        }
    }
    
    func sharingPost(post : String)-> String { //공유
        post
    }
    
}
