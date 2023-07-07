# 07.06 Random Element

## SwiftUI

Text(" ") 대신 Label("") 사용하는 방법
- Label("선택", systemImage: "checkmark.circle")
- Text 부분 생략하지 말고 자세히 적어주기
- image와 text를 상황에 맞게 머가 나올지 조정

Sheet 이용하는 방법
- 아래에서 뿅! 하고 튀어나오는거!

## Swift

MemberListViewModel -> 이런식으로 이름 지으면, 해당 뷰에서만 사용하도록 되어있기 때문에, MemberStore 이런식으로 이름 짓는게 좋다.

@Published var members: [Member]
- @Published members 배열 내부 내용이 변하면 알려주께!

@ObservedObject var memberStore: MemberStore = MemberStore()
- @ObservedObject : memberStore를 관찰을 해서 바디 새로 그릴게!

@State var isShowingSheet: Bool = false
- Binding 시 @State 해주고 $isShowingSheet 해줘야한다.

@Binding var isShowingSheet: Bool
- @Binding MemberListView의 isShowingSheet 를 공유하는 거다!
