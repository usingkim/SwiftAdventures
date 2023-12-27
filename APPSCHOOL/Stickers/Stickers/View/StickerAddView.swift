//
//  StickerAddView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI

struct StickerAddView: View {
    var stickerStore: StickerStore
    @Binding var isShowingSheet: Bool
    
    @State var selectedColor: Color = .cyan
    @State var memo: String = ""
    
    let colors: [Color] = [.cyan, .purple, .blue, .yellow, .brown]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Group{
                    Text("Select a color")
                        .font(.title)
                    HStack {
                        ForEach(colors, id:\.self) { color in
                            StickerColorSelectView(selectedColor: $selectedColor, color: color)
                        }
                    }
                }
                
                Divider()
                    .padding()
                
                Group {
                    Text("Write a memo")
                        .font(.title)
                    // axis 라는 옵션을 정해쥬면 위아래로 길어지는 메모장 가능하댜
                    TextField("Memo", text: $memo, axis: .vertical)
                        .font(.title)
                }
                
                
                
            }
            .navigationTitle("Add a Sticker!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isShowingSheet = false
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        stickerStore.addSticker(memo: memo, color: selectedColor)
                        isShowingSheet = false
                    } label: {
                        Text("Submit")
                    }

                }
            }
            .padding()
            
            Spacer()
            
        }
        
    }
}

struct StickerAddView_Previews: PreviewProvider {
    static var previews: some View {
        StickerAddView(stickerStore: StickerStore(), isShowingSheet: .constant(true))
    }
}
