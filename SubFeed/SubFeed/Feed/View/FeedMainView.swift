//
//  FeedMainView.swift
//  S_nowManCustomer
//
//  Created by cha_nyeong on 2023/08/24.
//

import SwiftUI

/*
 Post -> Feed 로 바꿔야함
 */

struct FeedMainView: View {
    @StateObject private var feedStore: FeedStore = FeedStore()
    @StateObject var replyStore = ReplyStore()
    @State private var isAddingPost : Bool = false
    @State private var isShowingAlert : Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView{
                Divider()
                ForEach(feedStore.feeds) { feed in
                    Spacer(minLength: 30)
                    FeedCellView(feed: feed, feedStore: feedStore, replyStore: replyStore, isShowingAlert: $isShowingAlert)
                    Spacer()
                    Divider()
                }
            }
            .foregroundColor(.black)
            
        }
        .navigationTitle("피드")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $isAddingPost) {
            NavigationStack{
                FeedAddView(isShowingSheet: $isAddingPost, feedStore: feedStore)
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
        .onAppear{feedStore.fetchFeeds()}
    }
}
struct FeedMainView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            FeedMainView()
        }
    }
}
