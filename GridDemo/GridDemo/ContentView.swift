//
//  ContentView.swift
//  GridDemo
//
//  Created by 김유진 on 2023/07/31.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack{

        }
    }
}

struct sheetDemo: View {
    @State private var showingSheet: Bool = false
    
    var body: some View {
        VStack{
            Button {
                showingSheet.toggle()
            } label: {
                Text("ShowingSheet!")
                    .font(.largeTitle)
            }

        }
        .sheet(isPresented: $showingSheet) {
            Text("This is sheet!")
                .presentationDetents([.medium, .large, .fraction(0.70)])
            // .medium 예시 사파리 -> 공유 버튼 느낌
        }
    }
}


struct ATMMCIscoreView: View {
    @State var atmScore: Int = 0
    @State var mciScore: Int = 0
    
    var body: some View {
        VStack{
            Spacer()
            Grid{
                GridRow{
                    Text("AT Madrid")
                        .lineLimit(1)
                    
                    ForEach(0..<atmScore, id: \.self) { _ in
                        Circle()
                            .fill(.red)
                            .frame(width:15)
                    }
                    
                    
                }
                GridRow
                {
                    Text("Man City")
                    ForEach(0..<mciScore, id: \.self) { _ in
                        Circle()
                            .fill(.blue)
                            .frame(width:15)
                    }
                    
                }
            }
            
            Spacer()
            
            HStack{
                Spacer()
                Button {
                    atmScore += 1
                } label: {
                    Text("ATM")
                }
                Spacer()
                Button {
                    mciScore += 1
                } label: {
                    Text("MCI")
                }
                Spacer()
                
            }
            Spacer()
        }
    }
}

struct SpaceDemoView: View {
    var body: some View {
        Grid(horizontalSpacing: 50, verticalSpacing: 50) {
                    GridRow {
                        Image(systemName: "xmark")
                        Image(systemName: "xmark")
                        Image(systemName: "xmark")
                    }
                    
                    GridRow {
                        Image(systemName: "circle")
                        Image(systemName: "xmark")
                        Image(systemName: "circle")
                    }
                
                    GridRow {
                        Image(systemName: "xmark")
                        Image(systemName: "circle")
                        Image(systemName: "circle")
                    }
                }
                .font(.largeTitle)
    }
}

struct MicroSoftView: View{
    var body: some View {
        Grid{
            GridRow {
                Text("Office")
                    .background(.red)
                    .padding()
                
                Text("Xbox")
                    .background(.green)
                    .padding()
                
            }
            GridRow{
                Text("Windows")
                    .background(.blue)
                    .padding()
                
                Text("Bing")
                    .background(.yellow)
                    .padding()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
