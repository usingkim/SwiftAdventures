//
//  imageSelectView.swift
//  S_nowManCustomer
//
//  Created by 김유진 on 2023/08/25.
//

import SwiftUI
import PhotosUI


struct imageSelectView: View {
    @Binding var feedImage: UIImage
    
    @State private var selectedItems: [PhotosPickerItem] = []
    private let numOfMaxImages: Int = 1
    
    
    
    var body: some View {
        VStack{
            PhotosPicker(selection: $selectedItems, maxSelectionCount: numOfMaxImages, matching: .images) {
                HStack{
                    Image(systemName: "paperclip")
                        .foregroundColor(.gray)
                    Spacer()
                }.padding()
                
                
            }
            .padding()
            .frame(height: 70)
        }
        .onChange(of: selectedItems) { _ in
            Task{
                for item in selectedItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let image = UIImage(data: data) {
                            feedImage = image
                        }
                    }
                }
            }
        }
    }
    
    
}

