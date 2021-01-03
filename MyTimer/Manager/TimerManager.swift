//
//  TimeManager.swift
//  MyTimer
//
//  Created by RB on 2021-01-03.
//

import SwiftUI

class TimerManager: ObservableObject {
    
    // MARK: - Class Variables
    
    enum TimerMode {
        case running
        case paused
        case initial
    }
    
    // MARK: - Properties

    @Published var timerMode: TimerMode = .initial
    @Published var secondsLeft = UserDefaultsManager.Keys.timerLength
    
    private var timer = Timer()
    
    // MARK: - Class Functions
    
    func start() {
        timerMode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { timer in
            if self.secondsLeft == 0 {
                self.reset()
            }
            self.secondsLeft -= 1
        })
    }
    
    func pause() {
        timerMode = .paused
        timer.invalidate()
    }
    
    func reset() {
        timerMode = .initial
        secondsLeft = UserDefaultsManager.Keys.timerLength
        timer.invalidate()
    }
    
    func setTimerLength(to minutes: Int) {
        UserDefaultsManager.Keys.timerLength = minutes
        secondsLeft = minutes
    }
}
