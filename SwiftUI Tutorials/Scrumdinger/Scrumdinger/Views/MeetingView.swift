//
//  ContentView.swift
//  Scrumdinger
//
//  Created by 김유진 on 2023/08/01.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }
        
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.theme.mainColor)
            VStack{
                // full : 15 value : 내가 설정
                //                ProgressView(value: 10, total: 15)
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                //                HStack {
                //                    VStack (alignment: .leading){
                //                        Text("Seconds Elapsed")
                //                            .font(.caption)
                //                        Label("300", systemImage: "hourglass.tophalf.fill")
                //                    }
                //                    Spacer()
                //                    VStack(alignment: .trailing){
                //                        Text("Seconds Remaining")
                //                            .font(.caption)
                //                        Label("600", systemImage: "hourglass.bottomhalf.fill")
                //                    }
                //                }
                //                // voice over 사용시
                //                .accessibilityElement(children: .ignore)
                //                .accessibilityLabel("Time remaining")
                //                .accessibilityValue("10 minutes")
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                
                //                HStack {
                //                    Text("Speaker 1 of 3")
                //                    Spacer()
                //                    Button (action: {}) {
                //                        Image(systemName: "forward.fill")
                //                    }
                //                    // Next Speaker Button 이라고 읽어줌
                //                    .accessibilityLabel("Next Speaker")
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.theme.accentColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
                       }
            scrumTimer.startScrum()
        }
        .onDisappear{
            scrumTimer.stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
