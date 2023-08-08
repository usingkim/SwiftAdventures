//
//  CircleImageView.swift
//  Landmarks
//
//  Created by 김유진 on 2023/07/31.
//

import SwiftUI

struct CircleImageView: View {
    var body: some View {
            Image("turtlerock")
                .clipShape(Circle())
                .overlay {
                    Circle().stroke(.white, lineWidth: 4)
                }
                .shadow(radius: 7)
        }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}
