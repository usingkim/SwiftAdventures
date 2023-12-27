//
//  ObservableDemoApp.swift
//  ObservableDemo
//
//  Created by 김유진 on 2023/07/24.
//

import SwiftUI

@main
struct ObservableDemoApp: App {
    let timerData = TimerData()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(timerData)
        }
    }
}
