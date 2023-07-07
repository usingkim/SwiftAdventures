//
//  StickerAddView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI

struct StickerAddView: View {
    @Binding var isShowingSheet: Bool
    
    let colors: [Color] = [.cyan, .purple, .blue, .yellow, .brown]
    
    var body: some View {
        NavigationStack {
            List{
                Section ("Select a color") {
                    HStack {
                        ForEach(colors, id:\.self) { color in
                            Rectangle()
                                .foregroundColor(color)
                                .frame(height: 50)
                                .shadow(radius: 6)
                        }
                    }
                }
            }
            .navigationTitle("Add a Sticker!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        isShowingSheet = false
                    }
                }
            }
            
        }
        
    }
}

struct StickerAddView_Previews: PreviewProvider {
    static var previews: some View {
        StickerAddView(isShowingSheet: .constant(true))
    }
}
