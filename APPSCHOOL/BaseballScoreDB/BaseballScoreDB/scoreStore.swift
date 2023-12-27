//
//  scoreStore.swift
//  BaseballScoreDB
//
//  Created by 김유진 on 2023/08/17.
//

import Foundation
import Firebase

class scoreStore : ObservableObject{
    @Published var homeScore: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @Published var awayScore: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0]
    @Published var inningIdx: Int = 0
    @Published var topOrBottom: Int = 0
    
    init() {
        
    }
    
    func fetchScore() async {
        Database.database().reference().child("inning").observe(.value) { snapshot in
            if let value = snapshot.value as? String {
                if let savedData = value.data(using: .utf8) {
                        DispatchQueue.main.async {
                            self.inningIdx = Int(savedData[0])
                    }
                }
            }
        }
    }
}
