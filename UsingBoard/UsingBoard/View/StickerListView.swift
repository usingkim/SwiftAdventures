//
//  StickerListView.swift
//  UsingBoard
//
//  Created by 김유진 on 2023/08/18.
//

import SwiftUI

struct StickerListView: View {
    @StateObject private var stickerStore: StickerStore = StickerStore()
    
    @State private var isShowingAdd: Bool = false
    
    var body: some View {
        List(stickerStore.stickers) { sticker in
            StickerCellView(sticker: sticker)
        }
        .navigationTitle("Stickers")
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isShowingAdd.toggle()
                } label: {
                    Label("Add", systemImage: "square.and.pencil")
                }

            }
        }
        .sheet(isPresented: $isShowingAdd){
            AddingStickerView(isShowingAddView: $isShowingAdd)
        }
        .refreshable {
            stickerStore.fetchStickers()
        }
        .onAppear {
            stickerStore.fetchStickers()
        }
    }
}

struct StickerListView_Previews: PreviewProvider {
    static var previews: some View {
        StickerListView()
    }
}
