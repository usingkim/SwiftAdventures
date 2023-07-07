//
//  MemberListView.swift
//  RandomMember
//
//  Created by 김유진 on 2023/07/06.
//

import SwiftUI

struct MemberListView: View {
    
    @ObservedObject var memberStore: MemberStore = MemberStore()
    // @ObservedObject : memberStore를 관찰을 해서 바디 새로 그릴게!
    @State var isShowingSheet: Bool = false
    
    var body: some View {
        VStack {
            List(memberStore.members) { member in
                Text("\(member.name)")
            }
            
            MemberPickButtonView(memberStore: memberStore)
        }
        .navigationTitle("Members")
        .toolbar {
            // 일반 Button이 들어가면 안된다
            ToolbarItem(placement: .navigationBarTrailing) {
                // navigationBarLeading : 왼쪽
                // navigationBarTailing : 오른쪽
                Button {
                    // sheet 로 올라오도록 만들고자함
                    // navigationstack이랑 다르다.
                    isShowingSheet = true
                } label: {
                    Label("추가", systemImage: "person.badge.plus")
                }
            }
        }
        .sheet(isPresented: $isShowingSheet) {
            // <#T##Binding<Bool>#> - > $ 달러 기호로
            MemberAddView(memberStore: memberStore, isShowingSheet: $isShowingSheet)
        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            MemberListView()
        }
    }
}
