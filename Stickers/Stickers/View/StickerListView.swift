//
//  StickerListView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI


struct StickerListView: View {
    // Binding으로 넘기는 Bool, Int 같은 기본값에는 State Property Wrapper를 꼭 달아줘야한다.
    @State var isSheetPresented: Bool = false
    
    var body: some View {
        VStack{
            List{
                StickerView()
                StickerView()
                StickerView()
                StickerView()
                StickerView()
                StickerView()
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
            StickerAddView(isShowingSheet: $isSheetPresented)
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
