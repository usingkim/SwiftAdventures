//
//  StickerListView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI


struct StickerListView: View {
    /*
     StateObject와 ObservedObject 모두 Observable 프로토콜을 따르는 클래스를 관찰해서 body를 변경한다.
     StateObject와 ObservedObject는 슈퍼뷰와 서브뷰 사이에서 늘 새롭게 만들어지느냐, 아니면 그 상태를 유지하냐에서 동작 방식 차이가 존재한다.
     (자세한 건 나중에...)
     */
    @StateObject var stickerStore: StickerStore = StickerStore()
    
    // Binding으로 넘기는 Bool, Int 같은 기본값에는 State Property Wrapper를 꼭 달아줘야한다.
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        VStack{
            List(stickerStore.stickers){ sticker in
                StickerView(sticker: sticker, stickerStore: stickerStore)
            }
            
            //            Label("Add", systemImage: "plus.app")
            //            Image(systemName: "plus.app")
            //                .font(.largeTitle)
            //                .padding()
        }
        .listStyle(.plain)
        .navigationTitle("Stickers")
        .toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    isSheetPresented = true // toggle보다는 true/false로 명시적으로 적어주는게 좋을지도..
                } label: {
                    Label("Add", systemImage: "pencil.tip.crop.circle.badge.plus")
                }

                
            }
        }
        // content에는 View 이름
        .sheet(isPresented: $isSheetPresented) {
            StickerAddView(stickerStore: stickerStore, isShowingSheet: $isSheetPresented)
        }
        
    }
}

struct StickerListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            StickerListView()
        }
    }
}
