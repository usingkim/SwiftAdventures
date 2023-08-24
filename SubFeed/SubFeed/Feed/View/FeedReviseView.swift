//
//  FeedReviseView.swift
//  S_nowManCustomer
//
//  Created by dayexx on 2023/08/23.
//

import SwiftUI
import PhotosUI

struct FeedReviseView: View {
    
    @Binding var isShowingSheet : Bool
    
    @State var post : Post
    var postStore : PostStore
    
    @State var postImages: [UIImage] = []
    @State private var newString: String = ""
    @State private var stringArray: [String] = []
    @State private var userLetterData : String = ""
    @FocusState private var textFieldFocus: Bool
    
    var body: some View {
        ScrollView(){ //VStack -> ScrollView 게시글이 길어지면 스크롤 할 수 있도록 함.
            
            /* 게시글 수정뷰 */
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
                .onAppear { // 수정뷰일때 여기서 데이터 업데이트 해주면 됨
                    stringArray.append(post.letter)
                }
            
            
            /* 포토뷰 */
            if post.image.count == 0 && postImages.count == 0{
                // postImages로 이미지가 들어감
                imageSelectView(postImages: $postImages)
            }
            else {
                imageScrollView(postImages: $postImages)
            }
            
            
            Spacer()
        }
        .navigationTitle("게시물 수정")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    // Data Save Code //
                    
                    //엔터로 append하도록 지정했기 때문에, 모달을 닫기 전에 남아있는 문자열도 저장해줌
                    if !newString.isEmpty {
                        stringArray.append(newString)
                        newString = ""
                    }
                    
                    if post.image.count != 0 {
                        postImages = post.image
                    }
                    
                    isShowingSheet = false //모달 닫기
                    submit()
                    
                } label: {
                    Text("게시")
                }.foregroundColor(.blue) //새 글쓰기창 버튼 색과 수정 창 버튼 색이 다르게보여서 설정해둠.
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    isShowingSheet = false //모달 닫기
                } label: {
                    Text("취소")
                }.foregroundColor(.blue)
            }
        }
        .onAppear {
            postImages = post.image
        }
        
    }
    
    func submit() { //userLetterData는 String타입 유저게시물 데이터. 근데 데이터 받아올때도 \n를 기준으로 잘라서 넣어야 수정가능함
        userLetterData = stringArray.joined(separator: "\n")
        print(userLetterData)
        // stringArray = userLetterData.components(separatedBy: "\n") -> 반대로 잘라서 넣는 코드
        postStore.revisePost(post, userLetterData, postImages)
    }
}


struct FeedReviseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedReviseView(isShowingSheet: .constant(true) , post: Post(userName: "오리", userImage: "duck", organization: "멋쟁이사자", image: [], letter: "자고싶다", like: 3), postStore: PostStore())
        }
    }
}

