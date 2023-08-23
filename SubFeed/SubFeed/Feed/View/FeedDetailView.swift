//
//  FeedDetailView.swift
//  S_nowManCustomer
//
//  Created by dayexx on 2023/08/22.
//


import SwiftUI

struct FeedDetailView: View {
    @State var replyText : String
    var body: some View {
        ZStack{
            ScrollView {
                /* 게시물 */
                Spacer(minLength: 60)
                FeedCellView(post: Post(userName: "오리", userImage: "duck", organization: "멋쟁이사자들", image: "sin", letter: "응애", like: 3), postStore: PostStore())
                Divider().bold()
                
                
                /* 댓글 */
                ForEach(0..<3) { reply in
                    VStack(alignment: .leading) {
                        HStack {
                            ProfileImageView(image: "duck").frame(width: 20)
                            Text("오리").bold()
                            Spacer()
                            Text("2023년 08월 22일")
                        }
                        .font(.footnote)
                        Text("댓글")
                        Divider()
                        
                    }.padding()
                }
                Rectangle().fill(.white).frame(height : 80) //댓글 입력창 만큼 뷰 늘려줌
            }
            .navigationTitle("게시물")
            .navigationBarTitleDisplayMode(.inline)
            
            /* 댓글 입력창 */
            VStack{
                Spacer(minLength: 710) //FeedMainView에서 본거랑 스페이서가 다르게 보임
                ZStack{
                    Rectangle().fill(.white).frame(height : 80)
                    HStack {
                        TextField("오리님에게 댓글 남기기", text: $replyText)
                        Button("게시") {
                            replyText = ""
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

struct FeedDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FeedDetailView(replyText: "")
    }
}

