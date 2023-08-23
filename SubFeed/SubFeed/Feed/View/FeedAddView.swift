//
//  FeedAddView.swift
//  S_nowManCustomer
//
//  Created by dayexx on 2023/08/23.
//

import SwiftUI
import PhotosUI

struct FeedAddView: View {
    
    @Binding var isShowingSheet : Bool
    
    let numOfMaxImages: Int = 1
    var isNumOfImages1: Bool {
        if numOfImages == 1{
            return true
        }
        return false
    }
    
    // 수정시 postText로 값 들어오게 해놔서 이 부분 수정해야함. -> 수정했는데, 데이터 받아야 제대로 수정할것같음!
    
    @ObservedObject var postStore : PostStore
    
    @State var selectedItems: [PhotosPickerItem] = []
    @State var postImages: [UIImage] = []
    @State var numOfImages: Int = 0
    @State var textEditorHeight: CGFloat = 300
    
    @State private var newString: String = ""
    @State private var stringArray: [String] = []
    @State private var userLetterData : String = ""
    @FocusState private var textFieldFocus: Bool
    
    var body: some View {
        ScrollView(){ //VStack -> ScrollView 게시글이 길어지면 스크롤 할 수 있도록 함.
            
            /* 새 게시글 작성, 수정뷰 */
            VStack(alignment: .leading, spacing: 0.5){
                HStack{
                    ProfileImageView(image: "duck").frame(width: 40)
                    Text("오리").bold()
                }
                
                Spacer(minLength: 40)
                
                // 한 줄 입력마다 동적 Height가지는 게시글 TextField.
                // Text -> TextField로 수정함. 다른 줄도 수정할 수 있어야하기 때문
                ForEach(0..<stringArray.count, id: \.self) { index  in
                    TextField(stringArray[index], text: $stringArray[index])
                        .onSubmit{textFieldFocus = true}
                }
                TextField(stringArray.count==0 ? "새 게시글 작성" : "", text: $newString)
                    .focused($textFieldFocus) //포커스는 엔터 눌렀을때 젤 밑 TextField에 맞춤.
                    .onSubmit {
                        withAnimation(.easeIn(duration: 0.1)) { //Warning수정, iOS15부터 애니메이션 업데이트됨... 근데 이거 삭제할까요,,,,,? 이상해....
                            stringArray.append(newString)
                            newString = ""
                            textFieldFocus = true
                        }
                    }
                
            }.padding()
            
            
            /* 포토뷰 */
            if postImages.count == 0 {
                PhotosPicker(selection: $selectedItems, maxSelectionCount: numOfMaxImages, matching: .images) {
                    HStack{
                        Image(systemName: "paperclip")
                        //                        .resizable()
                        //                        .frame(width: 50, height: 40)
                            .foregroundColor(.gray)
                        Spacer()
                    }.padding()
                    
                    
                }
                .padding()
                .frame(height: 70)
                
            }
            else {
                ScrollView(.horizontal) {
                    HStack{
                        ForEach(postImages, id:\.self) { image in
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: 393)
                                .frame(maxHeight: 300)
                            //  .onTapGesture {
                            // Image Remove Code 삽입하는것도?
                            //                                    print("Clicked!")
                            //                                }
                        }
                    }
                }
                .scrollDisabled(isNumOfImages1)
            }
            
            Spacer()
            
        }
        .navigationTitle("새 게시물")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    //엔터로 append하도록 지정했기 때문에, 모달을 닫기 전에 남아있는 문자열도 저장해줌
                    if !newString.isEmpty {
                        stringArray.append(newString)
                        newString = ""
                    }
                    submit()
                    isShowingSheet = false //모달 닫기
                    
                    
                } label: {
                    Text("게시")
                }.foregroundColor(.blue) //새 글쓰기창 버튼 색과 수정 창 버튼 색이 다르게보여서 설정해둠.
            }
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
                numOfImages = postImages.count
            }
        }
        
    }
    
    func submit() { //userLetterData는 String타입 유저게시물 데이터. 근데 데이터 받아올때도 \n를 기준으로 잘라서 넣어야 수정가능함
        userLetterData = stringArray.joined(separator: "\n")
        print(userLetterData)
        // stringArray = userLetterData.components(separatedBy: "\n") -> 반대로 잘라서 넣는 코드
        
        postStore.addPost(Post(userName: "오리", userImage: "duck", organization: "멋쟁이사자", image: "sin", letter: userLetterData, like: 0))
    }
}


struct FeedAddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedAddView(isShowingSheet: .constant(true), postStore: PostStore())
        }
    }
}
