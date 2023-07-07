# Stickers Memo App

## SwiftUI
    
StickerAddView(isShowingSheet: .constant(true))
- preview에서 binding된 값 강제로 볼려면 .constant로 드가줘야됨

## Swift 

@State var isSheetPresented: Bool = false
- Binding으로 넘기는 Bool, Int 같은 기본값에는 State Property Wrapper를 꼭 달아줘야한다.

isSheetPresented = true / isSheetPresented.toggle()
- toggle보다는 true/false로 명시적으로 적어주는게 좋을지도..
