//
//  ContentView.swift
//  MyTimer
//
//  Created by RB on 2020-12-31.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Properties
    
    @StateObject private var timerManager: TimerManager = TimerManager()
    
    @State private var selectedPickerIndex = 0
    
    private let availableMinutes = Array(1...59)
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            VStack {
                Text(secondsToMinutesAndSeconds(seconds: timerManager.secondsLeft))
                    .font(.system(size: 80))
                    .padding(.top, 80)
                
                Image(systemName: timerManager.timerMode == .running ? "pause.circle.fill" : "play.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
                    .foregroundColor(.orange)
                    .onTapGesture {
                        if timerManager.timerMode == .initial {
                            timerManager.setTimerLength(to: availableMinutes[selectedPickerIndex] * 60)
                        }
                        timerManager.timerMode == .running ? timerManager.pause() : timerManager.start()
                    }
                
                if timerManager.timerMode == .paused {
                    Image(systemName: "gobackward")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .padding(.top, 40)
                        .onTapGesture {
                            timerManager.reset()
                        }
                }
                
                Picker(
                    selection: $selectedPickerIndex,
                    label: Text("")
                ) {
                    ForEach(0..<availableMinutes.count) {
                        Text("\(self.availableMinutes[$0]) min")
                    }
                }.labelsHidden()
                
                Spacer()
            }
            .navigationTitle("My Timer")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}
