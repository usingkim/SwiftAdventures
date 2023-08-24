import SwiftUI


/*
 1. 글쓰기 뷰 - FeedMainView 29번 줄
 2. 수정 뷰 - FeedCellView 77번 줄
 */

struct FeedMainView: View {
    @StateObject private var postStore: PostStore = PostStore()
    @State private var isAddingPost : Bool = false
    @State private var isShowingAlert : Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                Divider()
                
                ForEach(postStore.posts) { post in
                    Spacer(minLength: 30)
                    FeedCellView(post: post, postStore: postStore, isShowingAlert: $isShowingAlert)
                    
                    Spacer()
                    Divider()
                }
            }.foregroundColor(.black)
            
        }.navigationTitle("피드")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $isAddingPost) {
                NavigationStack{
                    FeedAddView(isShowingSheet: $isAddingPost, postStore: postStore)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAddingPost.toggle()
                    } label: {
                        Label("글쓰기", systemImage: "plus")
                    }
                }
            }
            .alert(isPresented: $isShowingAlert) {
                Alert(
                    title: Text("알림"),
                    message: Text("해당 게시물을 삭제하시겠습니까?"),
                    primaryButton: .default(Text("확인"), action: {
                        //postStore.removePost(selectedPost);
                    }),
                    secondaryButton: .cancel(Text("취소").foregroundColor(.red), action: {
                        
                    })
                )
            }
    }
}
struct FeedMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            FeedMainView()
        }
    }
}
