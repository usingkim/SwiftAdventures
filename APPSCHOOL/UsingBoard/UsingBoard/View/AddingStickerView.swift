//
//  AddingStickerView.swift
//  UsingBoard
//
//  Created by 김유진 on 2023/08/18.
//

import SwiftUI

struct AddingStickerView: View {
    @Binding var isShowingAddView: Bool
    
    @State private var memo: String = ""
    @State private var colorIdx: Int = 0
    
    var body: some View {
        NavigationStack {
            
            Form {
                Section("Memo"){
                    TextField("Add your memo", text: $memo, axis: .vertical)
                        
                }
                .padding()
            }
            .formStyle(.columns)
            .navigationTitle("New Sticker")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isShowingAddView.toggle()
                    }
                }
            }
        }
    }
}

struct AddingStickerView_Previews: PreviewProvider {
    static var previews: some View {
        AddingStickerView(isShowingAddView: .constant(true))
    }
}
