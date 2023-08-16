//
//  MemoStore.swift
//  YoojinMemoRealTime
//
//  Created by 김유진 on 2023/08/16.
//

import Foundation
import Firebase

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
        
        // server에서 가져오는 법
        Database.database().reference().child("memo").observe(.value) { snapshot in
            if let value = snapshot.value as? String {
                if let savedMemoData = value.data(using: .utf8) {
                    if let savedMemoArray = try? JSONDecoder().decode([Memo].self, from: savedMemoData) {
                        DispatchQueue.main.async {
                            self.memoArray = savedMemoArray
                        }
                    }
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
        let memo: Memo = Memo(text: text)
        memoArray.append(memo)
        Task {
            await saveMemo()
        }
    }
    
    func removeMemo(at Offsets: IndexSet) {
        memoArray.remove(atOffsets: Offsets)
    }
}
