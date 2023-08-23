//
//  ContentView.swift
//  BaseballScoreDB
//
//  Created by 김유진 on 2023/08/17.
//

import SwiftUI

struct ContentView: View {
    let inning = [["1회 초", "1회 말"], ["2회 초", "2회 말"], ["3회 초", "3회 말"], ["4회 초", "4회 말"], ["5회 초", "5회 말"], ["6회 초", "6회 말"], ["7회 초", "7회 말"], ["8회 초", "8회 말"], ["9회 초", "9회 말"]]
    @StateObject var scoreStore: scoreStore = scoreStore()
    
    var body: some View {
        VStack{
            HStack {
                Grid {
                    GridRow{
                        let info: [String] = ["TEAM", "1", "2", "3", "4", "5", "6", "7", "8", "9", "R"]
                        
                        ForEach(info, id: \.self) { i in
                            Text("\(i)")
                        }
                    
                    }
                    Divider()
                    
                    GridRow{
                        Text("AWAY")
                            .bold()

                        ForEach (0..<scoreStore.awayScore.count){ i in
                            if (i > scoreStore.inningIdx) {
                                Text("")
                            }
                            else {
                                Text("\(scoreStore.awayScore[i])")
                                
                            }
                            
                        }
                        
                        Text("\(scoreStore.awayScore.reduce(0, +))")
                        
                    }
                    GridRow{
                        Text("HOME")
                            .bold()
                        ForEach (0..<scoreStore.homeScore.count){ i in
                            if (!(i == scoreStore.inningIdx && scoreStore.topOrBottom == 0)){
                                if (i > scoreStore.inningIdx) {
                                    Text("")
                                }
                                else {
                                    Text("\(scoreStore.homeScore[i])")
                                }
                            }
                            else {
                                Text("")
                            }
                        }
                        
                        Text("\(scoreStore.homeScore.reduce(0, +))")
                    }
                }
                .padding()
                
                
            }
            .padding()
            
            HStack {
                Text("\(inning[scoreStore.inningIdx][scoreStore.topOrBottom])")
                
                if !(scoreStore.topOrBottom == 1 && scoreStore.inningIdx == 8) {

                    Button {
                        if scoreStore.topOrBottom == 0{
                            scoreStore.topOrBottom = 1
                        }
                        else {
                            scoreStore.inningIdx += 1
                            scoreStore.topOrBottom = 0
                        }
                        
                        
                    } label: {
                        Text("다음 회")
                    }
                }
            }
            
            HStack {
                Button {
                    if scoreStore.topOrBottom == 0 {
                        scoreStore.awayScore[scoreStore.inningIdx] += 1
                    }
                    else {
                        scoreStore.homeScore[scoreStore.inningIdx] += 1
                    }
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
                Button {
                    if scoreStore.topOrBottom == 0 {
                        scoreStore.awayScore[scoreStore.inningIdx] -= 1
                    }
                    else {
                        scoreStore.homeScore[scoreStore.inningIdx] -= 1
                    }
                } label: {
                    Image(systemName: "arrow.down.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(.black)
                }
            }
        }
        .onAppear{
            Task {
                await scoreStore.fetchScore()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
