//
//  ViewController.swift
//  PomoProd
//
//  Created by Devron Tombacco on 11/12/2020.
//

import UIKit

class PomodoroVC: UIViewController {
    
    
    // MARK:-- Pomodoro Timer Variables
    var pomodoroTimer: Timer?
    var mins: Int = 0
    var secs: Int = 0
    var pomodoroCount: Int = 0
    
    
    // MARK:-- Short Break Timer Variables
    var breakTimer: Timer?
    var breakMins: Int = 0
    var breakSecs: Int = 0
    var breakCount: Int = 0
    
    
    // MARK:-- Long Break Timer Variables
    var longBreakTimer: Timer?
    var longBreakMins: Int = 0
    var longBreakSecs: Int = 0

    
    // MARK: -- General Variables
    var userSelectedPomodoroNumber = 0
    
    
    // MARK:-- Outlets
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pomodoroCountLabel: UILabel!
    
    override func viewDidLoad() {
        pomodoroCountLabel!.text = "Set time to begin"
        highlightCountLabel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentSettingsVCSegue", let vc = segue.destination as? SettingsVC {
            vc.pomodoroTimeDelegate = self
            vc.shortBreakTimeDelegate = self
            vc.longBreakTimeDelegate = self
            vc.pomodorosInSetDelegate = self
        }
    }

    // MARK:-- IBActions
    @IBAction func playButtonTapped(_ sender: UIButton) {
        startCountDown()
    }
    
    @IBAction func pauseButtonTapped(_ sender: UIButton) {
        pauseCountDown()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopCountDown()
        playButton.isEnabled = false
        pauseButton.isEnabled = false
    }
    
    
    // MARK:-- Methods
    func highlightCountLabel(){
        
        pomodoroCountLabel.layer.borderWidth = 1
        pomodoroCountLabel.layer.borderColor = K.color.highlighted
        
    }
    
    func pauseCountDown(){
        pomodoroTimer?.invalidate()
        breakTimer?.invalidate()
        longBreakTimer?.invalidate()
        resetCounts()
        pomodoroCountLabel!.text = "Timer Paused"
    }
    
    func stopCountDown(){
        pomodoroTimer?.invalidate()
        breakTimer?.invalidate()
        longBreakTimer?.invalidate()
        resetTimeValues()
        pomodoroCountLabel!.text = "Pomodoro STOPPED"
        updatePomodoroMinsAndSecsLabel()
    }
    
    func resetTimeValues(){
        // reset all timers to zero
        mins = 0
        secs = 0
        breakMins = 0
        breakSecs = 0
        longBreakMins = 0
        longBreakSecs = 0
    }
    
    func resetCounts(){
        pomodoroCount -= 1
        print("The current pomodoro is: \(pomodoroCount)")
        
        if breakCount == 0 {
            breakCount = 0
        } else {
            breakCount -= 1
        }
        print("The next break is: \(breakCount)")
    }
    
    private func updatePomodoroMinsAndSecsLabel(){
        minutesLabel.text = "\(mins)"
        secondsLabel.text = "\(secs)"
    }
    
    private func updatePomodoroShortBreakMinsAndSecsLabel(){
        minutesLabel.text = "\(breakMins)"
        secondsLabel.text = "\(breakSecs)"
    }
    
    private func updatePomodoroLongBreakMinsAndSecsLabel(){
        minutesLabel.text = "\(longBreakMins)"
        secondsLabel.text = "\(longBreakSecs)"
    }
    

    private func updatePomorodoCountLabel(){
        pomodoroCountLabel.text! = "Pomodoro \(pomodoroCount) of \(userSelectedPomodoroNumber)"
    }
    
    
    private func changePomodoroCountLabelToShortBreak(){
        pomodoroCountLabel.text! = "Short Break \(breakCount) of \(userSelectedPomodoroNumber - 1)"
    }
    
    private func changePomodoroCountLabelToLongBreak(){
        pomodoroCountLabel.text! = "Long Break"
    }
    
    private func pomodoroSeriesComplete(){
        pomodoroCountLabel.text! = "Pomodoro Series Completed"
    }

}

extension PomodoroVC {
    
    // MARK: Pomodoro Timer Function
    func startCountDown(){
        
        pomodoroCount += 1
        if pomodoroCount <= userSelectedPomodoroNumber {
            print("Pomodoro: \(pomodoroCount)")
            print("\(mins):\(secs)")
            pomodoroTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        } else {
            startLongBreakTimer()
        }
        
    }
    
    @objc func countDown(){
        
        if secs == 0 && mins == 0 {
            
            // Stop timer when count down has finished
            pomodoroTimer?.invalidate()
            startShortBreakCountDown()
        } else if secs > 0 {
            // decrement seconds by one
            secs = secs - 1
            print("\(mins):\(secs)")
        } else if secs == 0 {
            // when secs get to 0, decrement mins
            mins = mins - 1
            secs = 59
            print("\(mins):\(secs)")
        }
        
        updatePomodoroMinsAndSecsLabel()
        updatePomorodoCountLabel()
    }
}

extension PomodoroVC {
    
    // MARK: Short Break Timer Function
    
    func startShortBreakCountDown(){
        
        breakCount += 1
            if breakCount <= userSelectedPomodoroNumber - 1 {
                print("Break: \(breakCount)")
                print("\(breakMins):\(breakSecs)")
                breakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(shortBreakCountDown), userInfo: nil, repeats: true)
            } else {
                startLongBreakTimer()
            }
        
    }
    
    @objc func shortBreakCountDown(){
        
        if breakMins == 0 && breakSecs == 0 {
            
            // Stop timer when count down has finished
            breakTimer?.invalidate()
            
            // reset pomodoro time
            mins = 0
            secs = 10
            
            // reset break time
            breakMins = 0
            breakSecs = 5
            
            startCountDown()

            }
            else if breakSecs > 0 {
                // decrement seconds by one
                breakSecs = breakSecs - 1
                print("\(breakMins):\(breakSecs)")
            }
            else if breakSecs == 0 {
                // when secs get to 0, decrement mins
                breakMins = breakMins - 1
                breakSecs = 5
                print("\(breakMins):\(breakSecs)")
            }
            
        changePomodoroCountLabelToShortBreak()
        updatePomodoroShortBreakMinsAndSecsLabel()
    }
    
    
}

extension PomodoroVC {
    
    // MARK: Long Break Timer Function
    
    func startLongBreakTimer(){

        print("Long Break")
        longBreakTimer = Timer.scheduledTimer(timeInterval: 1, target: self,selector:#selector(longBreakCountDown), userInfo: nil, repeats: true)
        }
    
    @objc func longBreakCountDown(){
        
        if longBreakMins == 0 && longBreakSecs == 0 {
            
            // Stop timer when count down has finished
            print("Pomodoro Series Completed")
            pomodoroCountLabel.text! = "Pomodoro Series Completed"
            longBreakTimer?.invalidate()
            
            // reset pomodoro time
            // longBreakMins = 0
            // longBreakSecs = 10
            
            // reset break time
            // longBreakMins = 0
            // longBreakSecs = 5

            }
            else if longBreakSecs > 0 {
                // decrement seconds by one
                longBreakSecs = longBreakSecs - 1
                changePomodoroCountLabelToLongBreak()
                print("\(longBreakMins):\(longBreakSecs)")
                updatePomodoroLongBreakMinsAndSecsLabel()
            }
            else if longBreakSecs == 0 {
                // when secs get to 0, decrement mins
                longBreakMins = longBreakMins - 1
                longBreakSecs = 5
                changePomodoroCountLabelToLongBreak()
                print("\(longBreakMins):\(longBreakSecs)")
                updatePomodoroLongBreakMinsAndSecsLabel()
            }
            
    }
    
}


extension PomodoroVC: PomodoroTimeDelegate {
    
    func passPomodoroTimeData(pomodoroTimeData: Int) {
        mins = pomodoroTimeData
        secs = 0
        updatePomodoroMinsAndSecsLabel()
    }
    
}

extension PomodoroVC: ShortBreakTimeDelegate {
    
    func passShortBreakTimeData(shortBreakTimeData: Int) {
        breakMins = shortBreakTimeData
        secs = 0
    }
    
}
 
extension PomodoroVC: LongBreakTimeDelegate {
    
    func passLongBreakTimeData(longBreakTimeData: Int) {
        longBreakMins = longBreakTimeData
        secs = 0
    }

}

extension PomodoroVC: PomodorosInSetDelegate {
    
    func passPomdorosInSetData(pomodorosInSetData: Int) {
        userSelectedPomodoroNumber = pomodorosInSetData
    }
    
}
