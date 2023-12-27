//
//  imageScrollView.swift
//  S_nowManCustomer
//
//  Created by 김유진 on 2023/08/25.
//

import SwiftUI
import FirebaseStorage
import Firebase

enum mode {
    case revise
    case add
    case show
}

struct imageScrollView: View {
    var mode: mode = .show
    var id: String
    @Binding var feedImage: UIImage
    
    var body: some View {
        VStack{
            Image(uiImage: feedImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .contextMenu(menuItems: {
                    if mode != .show{
                        Button(action: {
                            feedImage = UIImage()
                            let firebaseReference = Storage.storage().reference().child(FEED_IMAGES + id)
                            firebaseReference.delete { error in
                                if error != nil {
                                print("삭제 x")
                              } else {
                                print("삭제 o")
                              }
                            }
                        }) {
                            // TODO: Label 빨간색 바꾸기
                            Text("삭제")
                            Image(systemName: "trash")
                            
                            
                        }
                    }
                })
                .frame(width: 396, height: 300)
            
            Button {
                
                Task {
                    await downloadImage()
                }
            } label: {
                Text("Reload")
            }
        }
        .onAppear {
            Task {
                await downloadImage()
            }
        }
        
    }
    
    func downloadImage() async {
        let firebaseReference = Storage.storage().reference().child(FEED_IMAGES + id)
        let megaByte = Int64(1 * 1024 * 1024)
        
        await firebaseReference.getData(maxSize: megaByte) { data, error in
            if let image = data {
                feedImage = UIImage(data: image) ?? UIImage()
            }
        }
    }
}
