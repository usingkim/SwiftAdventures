//
//  FeedCellView.swift
//  S_nowManCustomer
//
//  Created by dayexx on 2023/08/22.
//

import SwiftUI

struct FeedCellView: View {
    var post : Post
    var postStore : PostStore
    @State var isClickedHeart : Bool = false
    @State private var isShowingSheet : Bool = false
    var body: some View {
        
        VStack(alignment: .leading) {
            
            /* 포스팅 프로필 */
            HStack {
                Spacer()
                ProfileImageView(image : post.userImage).frame(width: 60)
                Spacer(minLength: 30)
                VStack(alignment:.leading){
                    Text(post.userName).bold()
                    Text(post.organization).font(.footnote).foregroundColor(.gray).bold()
                    Text(post.createdDate)
                        .font(.system(size: 10)).foregroundColor(.gray)
                }
                Spacer(minLength: 140)
                
                //드롭다운 메뉴
                Menu{
                    ShareLink(item: postStore.sharingPost(post: post.letter))
                    Button(action: { isShowingSheet.toggle()}) {
                        Label("수정", systemImage: "pencil")
                    }
                    //Menu드롭다운에서 foregroundColor설정 불가(ButtonStyle, LebleStyle등 커스텀으로 지정해줘도 안됐음), role로 지정해줘야되는데 삭제랑 색깔이 겹치는게 거슬림
                    Button(role: .destructive, action: { postStore.reportPost(post); print("\(post.isReported)")}) {
                        Label("신고", systemImage: "exclamationmark.triangle.fill").bold()
                    }
                    Button(role: .destructive, action: { postStore.removePost(post)}) {
                        Label("삭제", systemImage: "trash").bold()
                    }
                } label : {
                    Image(systemName: "ellipsis")
                }.foregroundColor(.gray)
                .padding()
            }
            
            /* 포스팅 내용 */
            Text("\(post.letter)").padding()
            
            notBindingImageScrollView(postImages: post.image)
//            Image(uiImage: post.image[0])
                
            
            /* 좋아요, 댓글    TODO - 하트취소 구현   */
            HStack(){
                Button {
                    postStore.likePost(post)
                    isClickedHeart.toggle()
                    print("\(post.like)")
                } label: {
                    Image(systemName: isClickedHeart ? "heart.fill" : "heart").font(.system(size: 20)).foregroundColor(.pink)
                }.padding()
                
                NavigationLink{ // 댓글 누르면 디테일뷰(댓글뷰)로 이동
                    FeedDetailView(replyText: "")
                } label: {
                    Image(systemName: "bubble.right").font(.system(size: 20))
                }
                
                Spacer()
               
            }.foregroundColor(.black)
           
        } .sheet(isPresented: $isShowingSheet) {
            //수정 뷰
            NavigationStack{
                /*let image = UIImage(named: post.image) ?? UIImage()
                FeedC_U_View(isShowingSheet: $isShowingSheet, mode: .revise, post : post)*/
                FeedReviseView(isShowingSheet: $isShowingSheet, post:post, postStore: postStore)
            }
        }
    }
}


struct FeedCellView_Previews: PreviewProvider {
    static var previews: some View {
        FeedCellView(post: Post(userName: "오리", userImage: "duck", organization: "멋쟁이사자들", image: [UIImage(named: "sin") ?? UIImage()], letter: "집가고싶다", like: 3), postStore: PostStore())
    }
}
