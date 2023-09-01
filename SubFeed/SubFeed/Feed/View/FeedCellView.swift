//
//  FeedCellView.swift
//  S_nowManCustomer
//
//  Created by cha_nyeong on 2023/08/24.
//

import SwiftUI

import FirebaseStorage
import Firebase

struct FeedCellView: View {
    var feed : Feed
    @StateObject var feedStore : FeedStore
    
    @StateObject var replyStore: ReplyStore
    @State var isClickedHeart : Bool = false
    @State private var isShowingSheet : Bool = false
    @State private var isShowingReply : Bool = false
    @State private var isShowingReport : Bool = false
    @State private var feedImage: UIImage = UIImage()
    @Binding var isShowingAlert : Bool
    @State var detent : PresentationDetent = .medium
    
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            /* 포스팅 프로필 */
            HStack {
                Spacer()
                // MARK: post.profileImageURL Optional String이라, 임의로 빈 String으로 대체. 추후 수정 필요
                ProfileImageView(image : feed.profileImageURL ?? "").frame(width: 60)
                Spacer(minLength: 30)
                VStack(alignment:.leading){
                    Text(feed.username).bold()
                    //Text(feed.organization).font(.footnote).foregroundColor(.gray).bold()
                    Text(feed.createdDate)
                        .font(.system(size: 10)).foregroundColor(.gray)
                }
                Spacer(minLength: 140)
                
                //드롭다운 메뉴
                Menu{
                    ShareLink(item: feedStore.sharingFeed(feed: feed.content))
                    Button(action: { isShowingSheet.toggle()}) {
                        Label("수정", systemImage: "pencil")
                    }
                    // MARK: 본인 게시물 -> 삭제 / 타인 게시물 -> 신고 만 뜨도록
                    //Menu드롭다운에서 foregroundColor설정 불가(ButtonStyle, LebleStyle등 커스텀으로 지정해줘도 안됐음), role로 지정해줘야되는데 삭제랑 색깔이 겹치는게 거슬림
                    Button(role: .destructive, action: { /*feedStore.reportFeed(feed);*/ isShowingReport = true}) {
                        Label("신고", systemImage: "exclamationmark.triangle.fill").bold()
                    }
                    Button(role: .destructive, action: {isShowingAlert = true}) {
                        Label("삭제", systemImage: "trash").bold()
                    }
                } label : {
                    Image(systemName: "ellipsis")
                }.foregroundColor(.gray)
                    .padding()
            }
            
            /* 포스팅 내용 */
            Text("\(feed.content)").padding()
            imageScrollView(id: feed.id, feedImage: $feedImage)
            
            
            /* 좋아요, 댓글    TODO - 하트취소 구현   */
            HStack(){
                Button {
                    if isClickedHeart {
                        feedStore.unlikeFeed(feed)
                    }
                    else {
                        feedStore.likeFeed(feed)
                    }
                    
                    isClickedHeart.toggle()
//                    print("\(post.like)")
                } label: {
                    Image(systemName: isClickedHeart ? "heart.fill" : "heart").font(.system(size: 20)).foregroundColor(.pink)
                }
                
                Text("\(feed.like)")
                
                // TODO: 댓글 path연결 실패해서 접속 막아뒀음
                Button {
                    //isShowingReply = true
                } label: {
                    Image(systemName: "bubble.right").font(.system(size: 20))
                }
                
                
                Text("\(replyStore.replies.count)")
//                Text("\(post.like)")
                
                /*
                 NavigationLink{ // 댓글 누르면 디테일뷰(댓글뷰)로 이동
                 FeedDetailView(replyText: "")
                 } label: {
                 Image(systemName: "bubble.right").font(.system(size: 20))
                 }*/
                
                Spacer()
                
            }.foregroundColor(.black)
                .padding()
            
        } .sheet(isPresented: $isShowingSheet) {
            //수정 뷰
            NavigationStack{
                /*let image = UIImage(named: post.image) ?? UIImage()
                 FeedC_U_View(isShowingSheet: $isShowingSheet, mode: .revise, post : post)*/
                FeedReviseView(isShowingSheet: $isShowingSheet, feed:feed, feedStore: feedStore)
            }
        } .sheet(isPresented: $isShowingReply) {
            //댓글 뷰
            NavigationStack{
                FeedReplyView(replyStore: replyStore)
            }
        }.sheet(isPresented: $isShowingReport) {
            //신고 뷰
            NavigationStack{
                ReportView()
            }.presentationDetents([
                .medium,
                .large
            ], selection : $detent)
        }
        .alert(isPresented: $isShowingAlert) {
            // 삭제 alert
            Alert(
                title: Text("알림"),
                message: Text("해당 게시물을 삭제하시겠습니까?"),
                primaryButton: .default(Text("확인"), action: {
                    feedStore.removeFeed(feed)
                }),
                secondaryButton: .cancel(Text("취소").foregroundColor(.red), action: {

                })
            )
        }
        .onAppear{
            Task {
                await downloadImage()
            }
        }
        .onChange(of: feedImage) { newValue in
            Task {
                await downloadImage()
            }
        }
        
    }
    
    func downloadImage() async {
        let firebaseReference = Storage.storage().reference().child(FEED_IMAGES + feed.id)
        let megaByte = Int64(1 * 1024 * 1024)
        
        await firebaseReference.getData(maxSize: megaByte) { data, error in
            if let image = data {
                feedImage = UIImage(data: image) ?? UIImage()
            }
        }
    }
    
}
//
//struct FeedCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedCellView()
//    }
//}
