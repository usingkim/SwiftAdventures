//
//  ContentView.swift
//  Landmarks
//
//  Created by 김유진 on 2023/07/31.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
                    MapView()
                        .ignoresSafeArea(edges: .top)
                        .frame(height: 300)


                    CircleImageView()
                        .offset(y: -130)
                        .padding(.bottom, -130)


                    VStack(alignment: .leading) {
                        Text("Turtle Rock")
                            .font(.title)


                        HStack {
                            Text("Joshua Tree National Park")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                            Spacer()
                            Text("California")
                                .font(.subheadline)
                        }
                    }
                    .padding()


                    Spacer()
                }
                .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
