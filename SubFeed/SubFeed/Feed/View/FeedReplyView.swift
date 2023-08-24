//
//  FeedReplyView.swift
//  SubFeed
//
//  Created by dayexx on 2023/08/24.
//

import SwiftUI

struct FeedReplyView: View {
    @StateObject var replyStore: ReplyStore // StateObject 유무 ... 나중에...
    @State private var replyText : String = ""
    
    var body: some View {
        
        
        ZStack{
            /* 댓글 */
            List{
                ForEach(replyStore.replies) { reply in
                    VStack(alignment: .leading) {
                        
                        HStack {
                            ProfileImageView(image: reply.imageString).frame(width: 20)
                            Text(reply.username).bold()
                            Spacer()
                            Text(reply.createdDate)
                        }
                        .font(.footnote)
                        
                        Text(reply.text)
                    }.padding()
                }.onDelete(perform: replyStore.deleteReply)
            }.listStyle(.plain)
            
            /* 댓글 입력창 */
            VStack{
                Spacer(minLength: 630) //FeedMainView에서 본거랑 스페이서가 다르게 보임
                ZStack{
                    Rectangle().fill(.white).frame(height : 80)
                    HStack {
                        TextField("오리님에게 댓글 남기기", text: $replyText)
                        Button("게시") {
                            replyStore.addReply(Reply(username: "오리", text: replyText, imageString: "duck"))
                            replyText = ""
                        }
                    }
                    .padding()
                }
            }
            
        } .navigationTitle("댓글")
            .navigationBarTitleDisplayMode(.inline)
        
    }
}

struct FeedReplyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            //                FeedReplyView()
        }
    }
}
