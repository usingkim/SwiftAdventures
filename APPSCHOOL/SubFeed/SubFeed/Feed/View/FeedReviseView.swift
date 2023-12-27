//
//  FeedReviseView.swift
//  S_nowManCustomer
//
//  Created by cha_nyeong on 2023/08/24.
//

import SwiftUI

import FirebaseStorage
import Firebase

struct FeedReviseView: View {
    
    @Binding var isShowingSheet : Bool
    
    @State var feed : Feed
    @ObservedObject var feedStore : FeedStore
    
    @State var feedImage: UIImage = UIImage()
    @State private var newString: String = ""
    @State private var stringArray: [String] = []
    @State private var userContentData : String = ""
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
                    stringArray.append(feed.content)
                }
            
            
            /* 포토뷰 */
            // 이 부분 조건 새로 설정해야한다
            imageScrollView(mode: .revise, id: feed.id, feedImage: $feedImage)

            imageSelectView(feedImage: $feedImage)
            
            
            
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
                    
                   //feed.feedImage = postImages
                    
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
            //postImages = feed.feedImage
        }
        
    }
    
    func submit() { //userLetterData는 String타입 유저게시물 데이터. 근데 데이터 받아올때도 \n를 기준으로 잘라서 넣어야 수정가능함
        userContentData = stringArray.joined(separator: "\n")
        print(userContentData)
        // stringArray = userLetterData.components(separatedBy: "\n") -> 반대로 잘라서 넣는 코드
        feedStore.reviseFeed(feed, userContentData, "duck")
        
        // Feed 수정 이미지 올리기
        Task{
            await uploadImage(image: feedImage)
        }
    }
    
    func uploadImage(image: UIImage) async {
        // Feed 이미지 삭제
        let firebaseReference = Storage.storage().reference().child(FEED_IMAGES + feed.id)
        firebaseReference.delete { error in
            if error != nil {
            print("삭제 x")
          } else {
            print("삭제 o")
          }
        }
        
        guard let imageData = image.jpegData(compressionQuality: 0.4) else { return }
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        
        firebaseReference.putData(imageData, metadata: metaData) { metaData, error in
            Task{
                try await firebaseReference.downloadURL()
            }
        }
    }
}


struct FeedReviseView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            FeedReviseView(isShowingSheet: .constant(true), feed:Feed(uid: "?", username: "오리", feedImage: "duck", content: "앙", like: 0), feedStore: FeedStore())
        }
    }
}
