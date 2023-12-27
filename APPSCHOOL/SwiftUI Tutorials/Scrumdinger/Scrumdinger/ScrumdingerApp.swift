//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by 김유진 on 2023/08/01.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.sampleData
    var body: some Scene {
        WindowGroup {
            ScrumsView(scrums: $scrums)
        }
    }
}
