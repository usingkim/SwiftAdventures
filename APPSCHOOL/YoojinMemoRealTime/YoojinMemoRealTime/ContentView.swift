//
//  ContentView.swift
//  YoojinMemoRealTime
//
//  Created by 김유진 on 2023/08/16.
//

import SwiftUI
import Firebase // Firebase 연동

struct ContentView: View {
    
    // Database -> RealTimeDB
    let databaseRef = Database.database().reference()
    
    @StateObject var memoStore: MemoStore = MemoStore()
    
    @State private var memoText: String = ""
    
    var body: some View {
        NavigationStack{
            VStack{
                List{
                    ForEach(memoStore.memoArray){ memo in
                        Text("\(memo.text)")
                    }
                    .onDelete { indexSet in
                        memoStore.removeMemo(at: indexSet)
                    }
                    
                }
                HStack {
                    TextField("add new memo", text: $memoText)
                    Button("Add") {
                        memoStore.addMemo(text: memoText)
                        memoText = ""
                    }
                }
                .padding()
            }
            .navigationTitle("Memo")
            .refreshable {
                Task {
                    await memoStore.fetchMemo()
                }
            }
            .onAppear{
                Task {
                    await memoStore.fetchMemo()
                }
            }
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
