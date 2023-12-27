//
//  ProfileImageView.swift
//  S_nowManCustomer
//
//  Created by cha_nyeong on 2023/08/24.
//

import SwiftUI

struct ProfileImageView: View {
    var image : String
    var body: some View {
        Image(image)
        .resizable()
        .scaledToFit()
        .clipShape(Circle())
    }
}

struct ProfileImageView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImageView(image : "duck")
    }
}
