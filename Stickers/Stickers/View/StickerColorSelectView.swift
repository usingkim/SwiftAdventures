//
//  StickerColorsView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI

struct StickerColorSelectView: View {
    @Binding var selectedColor: Color
    
    let color: Color
    
    var body: some View {
        Button {
            selectedColor = color
        } label: {
            ZStack{ // 위에 쌓음
                Rectangle()
                    .foregroundColor(color)
                    .frame(height: 50)
                    .shadow(radius: 6)
                // 보여줄지 말지로
                if selectedColor == color {
                    Image(systemName: "checkmark")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                }
            }
            
            
            
        }
    }
}

struct StickerColorsView_Previews: PreviewProvider {
    static var previews: some View {
        StickerColorSelectView(selectedColor: .constant(.cyan), color: .cyan)
    }
}
