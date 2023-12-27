//
//  TestView.swift
//  YoojinMemoRealTime
//
//  Created by 김유진 on 2023/08/16.
//

import SwiftUI
import Firebase

struct TestView: View {
    
    // Database -> RealTimeDB
    let databaseRef = Database.database().reference()
    
    @State private var lightOn: Bool = true
    
    var body: some View {
        VStack {
            if lightOn {
                Text("Light On!")
                    
            }
            else {
                Text("Light Off!")
            }
            
            Button("Toogle Light") {
                // local에서 db value 조정
                lightOn.toggle()
                databaseRef.child("lightOn").setValue(lightOn)
            }
        }
        .padding()
        .onAppear {
            observeLightState()
        }
    }
    
    // db value 에 따라 local 값 조정
    func observeLightState() {
        // https://console.firebase.google.com/u/0/project/yoojin-memo/database/yoojin-memo-default-rtdb/data/~2F?hl=ko의 child의 key lightOn 을 감시해라
        databaseRef.child("lightOn").observe(.value) { snapshot in
            if let value = snapshot.value as? Bool {
                lightOn = value
            }
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
