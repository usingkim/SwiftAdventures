//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by 김유진 on 2023/07/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var rotation: Double = 0
    @State var animationAmount = 1
    @State var textFieldString = "Welcome to SwiftUI"
    
    var colors: [Color] = [.black, .red, .green, .blue]
    var colorNames = ["Black", "Red", "Green", "Blue"]
    
    @State var colorIndex = 0
    
    var body: some View {
        VStack {
            Spacer()
            Text(textFieldString)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .rotationEffect(.degrees(self.rotation))
            // .animation에 value default 값이 원래 얼마였는지 알아보댜!
            // .easeInOut 자리에 들어가는 애들 차이점 알아보기!
                .animation(.easeInOut(duration: 5), value: animationAmount)
                .foregroundColor(self.colors[self.colorIndex])
            
            Spacer()
            Divider()
            
            // 0부터 360까지의 범위로 0.1씩 증가되도록 슬라이드 구성
            Slider(value: $rotation, in:0...360, step: 0.1)
                .padding()
            
            TextField("Enter text here", text: $textFieldString)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Picker(selection: $colorIndex, label: Text("Color")) {
                ForEach (0..<colorNames.count) {
                    Text(self.colorNames[$0])
                        .foregroundColor(self.colors[$0])
                }
            }
            .padding()
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
