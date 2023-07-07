//
//  MemberStore.swift
//  RandomMember
//
//  Created by 김유진 on 2023/07/06.
//

import Foundation


// protocol 을 따라야하기 때문에 class 받아야한다.
class MemberStore: ObservableObject{
    // Member가지고 노는 애
    @Published var members: [Member] // @Published members 배열 내부 내용이 변하면 알려주께!
    
    var randomMember: Member {
        members.randomElement() ?? Member(name: "(없는 사람)")
    }
    
    init() {
        members = [
            Member(name: "김주원"),
            Member(name: "손아섭"),
            Member(name: "유강남"),
            Member(name: "김민석"),
            Member(name: "신영우"),
            Member(name: "김서현"),
            Member(name: "윤영철"),
            Member(name: "이로운"),
            Member(name: "김건희")
        ]
    }
    
    func addMember(name: String) {
        let member: Member = Member(name: name)
        members.append(member)
    }
}
