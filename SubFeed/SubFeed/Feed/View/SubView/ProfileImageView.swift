//
//  profileImageView.swift
//  S_nowManCustomer
//
//  Created by dayexx on 2023/08/22.
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
