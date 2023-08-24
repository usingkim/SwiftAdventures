//
//  FeedImageViewStructs.swift
//  SubFeed
//
//  Created by 김유진 on 2023/08/24.
//

import SwiftUI
import PhotosUI

struct imageSelectView: View {
    
    @Binding var postImages: [UIImage]
    
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
                postImages.removeAll()
                for item in selectedItems {
                    if let data = try? await item.loadTransferable(type: Data.self) {
                        if let uiImage = UIImage(data: data) {
                            postImages.append(uiImage)
                        }
                    }
                }
            }
        }
    }
}

struct imageScrollView: View {
    @Binding var postImages: [UIImage]
    
    private var isNumOfImages1: Bool {
        if postImages.count == 1{
            return true
        }
        return false
    }
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack{
                ForEach(postImages, id:\.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        //.aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 396)
                        .frame(maxHeight: 300)
                }
            }
        }
        .scrollDisabled(isNumOfImages1)
    }
}
