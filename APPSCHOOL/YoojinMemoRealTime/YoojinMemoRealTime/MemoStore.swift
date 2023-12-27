//
//  MemoStore.swift
//  YoojinMemoRealTime
//
//  Created by 김유진 on 2023/08/16.
//

import Foundation
import Firebase
import FirebaseFirestore

class MemoStore: ObservableObject {
    @Published var memoArray: [Memo] = []
    
    init() {
        //        memoArray = [
        //            Memo(text: "Hello"),
        //            Memo(text: "Yoojin")
        //        ]
        
    }
    
    func fetchMemo() async {
        // UserDefault 에서 가져오는 법
        //        if let savedMemoData = UserDefaults.standard.object(forKey: "memo") as? Data {
        //            if let savedMemoArray = try? JSONDecoder().decode([Memo].self, from: savedMemoData) {
        //                DispatchQueue.main.async {
        //                    self.memoArray = savedMemoArray
        //                }
        //
        //            }
        //        }
        
        // Firebase의 Realtime Database 에서 가져오는 법
//        Database.database().reference().child("memo").observe(.value) { snapshot in
//            if let value = snapshot.value as? String {
//                if let savedMemoData = value.data(using: .utf8) {
//                    if let savedMemoArray = try? JSONDecoder().decode([Memo].self, from: savedMemoData) {
//                        DispatchQueue.main.async {
//                            self.memoArray = savedMemoArray
//                        }
//                    }
//                }
//            }
//        }
        
        // Firebase의 Cloud Firestore에서 읽기
        Firestore.firestore().collection("Memo").getDocuments { (snapshot, error) in
            if let snapshot {
                var savedMemoArray: [Memo] = []
                
                for document in snapshot.documents {
                    let id: String = document.documentID
                    
                    let docData = document.data()
                    let text: String = docData["text"] as? String ?? ""
                    
                    let memo: Memo = Memo(id: id, text: text)
                    savedMemoArray.append(memo)
                }
                
                DispatchQueue.main.async {
                    self.memoArray = savedMemoArray
                }
            }
        }
    }
    
    func saveMemo() async {
        if let encodedMemoArray = try? JSONEncoder().encode(memoArray) {
            //            UserDefaults.standard.set(encodedMemoArray, forKey: "memo")
            
            let resultString = String(data: encodedMemoArray, encoding: .utf8) ?? "none"
            print("\(resultString)")
            
            do {
                try await Database.database().reference().child("memo").setValue(resultString)
            } catch {
                print("firebase error")
            }
        }
    }
    
    func addMemo(text: String) {
        // RealTime
//        let memo: Memo = Memo(text: text)
//        memoArray.append(memo)
//        Task {
//            await saveMemo()
//        }
        
        let memo: Memo = Memo(text: text)
        
        Task {
            do {
                try await Firestore.firestore().collection("Memo")
                    .document(memo.id)
                    .setData(["text": memo.text])
                
                memoArray.append(memo)
            } catch {
                print("firestore error")
            }
        }
    }
    
    func removeMemo(at Offsets: IndexSet) {
        // RealTime
//        memoArray.remove(atOffsets: Offsets)
        
        for offset in offsets {
            print("\(offset)")
            let memo = memoArray[offset]
            print("\(memo)")
            
            Task {
                do {
                    try await Firestore.firestore().collection("Memo").document(memo.id).delete()
                } catch {
                    print("Firestore remove error")
                }
            }
            
            memoArray.remove(at: offset)
        }
    }
}
