//
//  StickerAddView.swift
//  Stickers
//
//  Created by 김유진 on 2023/07/07.
//

import SwiftUI

struct StickerAddView: View {
    @Binding var isShowingSheet: Bool
    
    @State var selectedColor: Color = .cyan
    
    let colors: [Color] = [.cyan, .purple, .blue, .yellow, .brown]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                Text("Select a color")
                    .font(.title)
                HStack {
                    ForEach(colors, id:\.self) { color in
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
                        print("submit")
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
        StickerAddView(isShowingSheet: .constant(true))
    }
}
