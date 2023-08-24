//
//  ReportView.swift
//  SubFeed
//
//  Created by dayexx on 2023/08/24.
//

import SwiftUI

struct ReportView: View {
    var reportReason : [String] = ["마음에 들지 않음", "스팸", "폭력성", "거짓 정보"]
    var body: some View {
        List(reportReason, id: \.self){ reason in
            NavigationLink {
                ReportResultView()
            } label: {
                VStack{
                    Text(reason)
                }.padding()
            }
        }.listStyle(.plain)
            .navigationTitle("신고")
            .navigationBarTitleDisplayMode(.inline)
    }
}
struct ReportResultView: View {
    var body: some View {
        VStack{
            Image(systemName: "checkmark.circle.fill").foregroundColor(.green).font(.system(size:60)).padding()
            Text("신고 완료!")
        }.padding()
            .navigationBarBackButtonHidden(true)
    }
}

struct ReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ReportView()
        }
    }
}
