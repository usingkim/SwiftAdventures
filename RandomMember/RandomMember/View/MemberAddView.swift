//
//  MemberAddView.swift
//  RandomMember
//
//  Created by 김유진 on 2023/07/06.
//

import SwiftUI

struct MemberAddView: View {
    var memberStore: MemberStore
    @Binding var isShowingSheet: Bool
    // @Binding MemberListView의 isShowingSheet 를 공유하는 거다!
    @State var name: String = ""
    
    
    var body: some View {
        NavigationStack{
            VStack{
                TextField("이름", text: $name)
                    .textFieldStyle(.roundedBorder)
                    .font(.largeTitle)
                    .padding()
            }
            .navigationTitle("New member")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowingSheet = false
                    } label: {
                        Text("취소")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        memberStore.addMember(name: name)
                        isShowingSheet = false
                    } label: {
                        Text("추가")
                    }
                }
            }
        }

    }
}

//struct MemberAddView_Previews: PreviewProvider {
//    static var previews: some View {
//        // MemberAddView(memberStore: memberStore, isShowingSheet: .constant(true))
//    }
//}
