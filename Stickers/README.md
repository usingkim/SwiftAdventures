# Stickers Memo App

## SwiftUI
    
StickerAddView(isShowingSheet: .constant(true))
- preview에서 binding된 값 강제로 볼려면 .constant로 드가줘야됨

TextField("Memo", text: $memo, axis: .vertical)
- axis 라는 옵션을 정해쥬면 위아래로 길어지는 메모장 가능하댜

## Swift 

class StickerStore: ObservableObject {
    @Published var stickers: [Sticker] = []
- Observable 이랑 @Published 해줘야 다른 View 파일에서 추적이 가능하다!

@State var isSheetPresented: Bool = false
- Binding으로 넘기는 Bool, Int 같은 기본값에는 State Property Wrapper를 꼭 달아줘야한다.

isSheetPresented = true / isSheetPresented.toggle()
- toggle보다는 true/false로 명시적으로 적어주는게 좋을지도..

class StickerStore: ObservableObject
- 다른 친구들아! 관찰좀 해줘! 라고 ObservableObject 사용

date를 dateString으로 변형해서 출력해주기 (Format에 따라)
    
    
    var date: Date
    
    var dateString: String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
