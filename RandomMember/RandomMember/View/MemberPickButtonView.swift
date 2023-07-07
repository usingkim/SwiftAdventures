//
//  MemberPickButtonView.swift
//  RandomMember
//
//  Created by 김유진 on 2023/07/06.
//

import SwiftUI

struct MemberPickButtonView: View {
    
    var memberStore: MemberStore
    
    var body: some View {
        NavigationLink {
            MemberPickView(memberStore: memberStore)
        } label: {
            Label("선택", systemImage: "hand.tap")
        }
    }
}
//
//struct MemberPickButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        // MemberPickButtonView()
//    }
//}
