//
//  ViewController.swift
//  PomoProd
//
//  Created by Devron Tombacco on 11/12/2020.
//

import UIKit
import AVFoundation

class PomodoroVC: UIViewController {
    
    
    // MARK:-- Pomodoro Timer Variables
    var pomodoroTimer: Timer?
    var pomodoroMins: Int = 0
    var pomodoroSecs: Int = 0
    var pomodoroCount: Int = 0
    
    
    // MARK:-- Short Break Timer Variables
    var shortBreakTimer: Timer?
    var shortBreakMins: Int = 0
    var shortBreakSecs: Int = 0
    var shortBreakCount: Int = 0
    
    
    // MARK:-- Long Break Timer Variables
    var longBreakTimer: Timer?
    var longBreakMins: Int = 0
    var longBreakSecs: Int = 0

    
    // MARK: -- General Variables
    var userSelectedPomodoroNumber = 0
    var userSelectedPomodoroMins: Int = 0
    var userSelectedShortBreakMins: Int = 0
    var userSelectedLongBreakMins: Int = 0
    var audioPlayer: AVAudioPlayer?
    
    
    // MARK:-- Outlets
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pomodoroCountLabel: UILabel!
    
    override func viewDidLoad() {
        pomodoroCountLabel!.text = "Set timer and breaks"
        highlightCountLabel()
        disablePlayStop()
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
        disablePlayAndSettings()
        enableStop()
    }
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopCountDown()
        disablePlayStop()
        enableSettings()
        resetCounts()
    }
    
    
    
    // MARK:-- UI Methods
    func highlightCountLabel(){
        pomodoroCountLabel.layer.borderWidth = 1
        pomodoroCountLabel.layer.borderColor = K.color.highlighted
    }
    
    
    // MARK: -- All Timer Methods
    
    func stopCountDown(){
        pomodoroTimer?.invalidate()
        shortBreakTimer?.invalidate()
        longBreakTimer?.invalidate()
        resetAllTimeValues()
        pomodoroCountLabel!.text = "Pomodoro STOPPED"
        updatePomodoroMinsAndSecsLabel()
    }
    
    // MARK: -- Reset Methods
    func resetAllTimeValues(){
        // reset all timers to zero
        pomodoroMins = 0
        pomodoroSecs = 0
        shortBreakMins = 0
        shortBreakSecs = 0
        longBreakMins = 0
        longBreakSecs = 0
    }
    
    func resetCounts(){
        pomodoroCount = 0
        shortBreakCount = 0
    }
    
    func resetPomodoroMins() {
        pomodoroMins = userSelectedPomodoroMins
        pomodoroSecs = 0
    }
    
    func resetShortBreakMins(){
        shortBreakMins = userSelectedShortBreakMins
        shortBreakSecs = 0
    }
    
    func resetLongBreakMins(){
        longBreakMins = userSelectedLongBreakMins
        longBreakSecs = 0
    }
    
    func resetPomodorosAndShortBreaks(){
        pomodoroMins = userSelectedPomodoroMins
        pomodoroSecs = 0
        shortBreakMins = userSelectedShortBreakMins
        shortBreakSecs = 0
        longBreakMins = userSelectedLongBreakMins
        longBreakSecs = 0
    }
    
    
    //MARK: -- Enable/Disable Buttons Methods
    func enablePlay(){
        playButton.isEnabled = true
    }
    
    func enableStop(){
        stopButton.isEnabled = true
    }
    
    func enableSettings(){
        settingsButton.isEnabled = true
    }

    
    // Disable Play button
    func disablePlayAndSettings(){
        playButton.isEnabled = false
        settingsButton.isEnabled = false
    }
    
    // Disable Stop button
    func disableStop(){
        stopButton.isEnabled = false
    }
    
    // Disable play and stop buttons
    func disablePlayStop(){
        playButton.isEnabled = false
        stopButton.isEnabled = false
    }

    
    // MARK: -- Update Labels Methods
    private func updatePomodoroMinsAndSecsLabel(){
        minutesLabel.text = "\(pomodoroMins)"
        secondsLabel.text = "\(pomodoroSecs)"
    }
    
    
    private func updatePomodoroShortBreakMinsAndSecsLabel(){
        minutesLabel.text = "\(shortBreakMins)"
        secondsLabel.text = "\(shortBreakSecs)"
    }
    
    
    private func updatePomodoroLongBreakMinsAndSecsLabel(){
        minutesLabel.text = "\(longBreakMins)"
        secondsLabel.text = "\(longBreakSecs)"
    }
    

    private func updatePomorodoCountLabel(){
        pomodoroCountLabel.text! = "Pomodoro \(pomodoroCount) of \(userSelectedPomodoroNumber)"
    }
    
    
    private func changePomodoroCountLabelToShortBreak(){
        pomodoroCountLabel.text! = "Short Break \(shortBreakCount) of \(userSelectedPomodoroNumber - 1)"
    }
    
    private func changePomodoroCountLabelToLongBreak(){
        pomodoroCountLabel.text! = "Long Break"
    }
    
    
    private func pomodoroSeriesReady(){
        pomodoroCountLabel.text! = "Pomodoro Series Ready"
    }
    
    
    private func pomodoroSeriesComplete(){
        pomodoroCountLabel.text! = "Pomodoro Series Completed"
    }

}

extension PomodoroVC {
    
    // MARK: Pomodoro Timer Function
    func startCountDown(){
        
        resetShortBreakMins()
        resetLongBreakMins()
        
        pomodoroCount += 1
        if pomodoroCount <= userSelectedPomodoroNumber {
            print("Pomodoro: \(pomodoroCount)")
            print("\(pomodoroMins):\(pomodoroSecs)")
            pomodoroTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
        } else {
            startLongBreakTimer()
        }
        
    }
    
    @objc func countDown(){
        
        if pomodoroSecs == 0 && pomodoroMins == 0 {
            
            // Stop timer when count down has finished
            pomodoroTimer?.invalidate()
            playSound()
            startShortBreakCountDown()
            
        } else if pomodoroSecs > 0 {
            // decrement seconds by one
            pomodoroSecs = pomodoroSecs - 1
            print("\(pomodoroMins):\(pomodoroSecs)")
            
        } else if pomodoroSecs == 0 {
            // when secs get to 0, decrement mins
            pomodoroMins = pomodoroMins - 1
            pomodoroSecs = 59
            print("\(pomodoroMins):\(pomodoroSecs)")
            
        }
        updatePomorodoCountLabel()
        updatePomodoroMinsAndSecsLabel()
        
    }
}

extension PomodoroVC {
    
    // MARK: Short Break Timer Function
    
    func startShortBreakCountDown(){
        
        shortBreakCount += 1
            if shortBreakCount <= userSelectedPomodoroNumber - 1 {
                print("Break: \(shortBreakCount)")
                print("\(shortBreakMins):\(shortBreakSecs)")
                shortBreakTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector:#selector(shortBreakCountDown), userInfo: nil, repeats: true)
            } else {
                startLongBreakTimer()
            }
        
    }
    
    @objc func shortBreakCountDown(){
        
        if shortBreakMins == 0 && shortBreakSecs == 0 {
            
            // Stop timer when count down has finished
            shortBreakTimer?.invalidate()
            playSound()
            
            // reset pomodoro time
            resetPomodoroMins()

            startCountDown()
            
            }
            else if shortBreakSecs > 0 {
                // decrement seconds by one
                shortBreakSecs = shortBreakSecs - 1
                print("\(shortBreakMins):\(shortBreakSecs)")
            }
            else if shortBreakSecs == 0 {
                // when secs get to 0, decrement mins
                shortBreakMins = shortBreakMins - 1
                shortBreakSecs = 59
                print("\(shortBreakMins):\(shortBreakSecs)")
            }
        
        updatePomodoroShortBreakMinsAndSecsLabel()
        changePomodoroCountLabelToShortBreak()
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
            playSound()
            longBreakTimer?.invalidate()
            disablePlayStop()
            resetCounts()
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
                longBreakSecs = 59
                updatePomodoroLongBreakMinsAndSecsLabel()
                changePomodoroCountLabelToLongBreak()
                print("\(longBreakMins):\(longBreakSecs)")
                updatePomodoroLongBreakMinsAndSecsLabel()
            }
    }
}

extension PomodoroVC {
    
    // MARK: -- Audio for alert
    func playSound(){
        
        let path = Bundle.main.path(forResource: "introTransition", ofType: "wav")!
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Couldn't load file :( ")
        }

    }
    
    func stopSound(){
        audioPlayer?.stop()
    }
    
}


extension PomodoroVC: PomodoroTimeDelegate {
    
    func passPomodoroTimeData(pomodoroTimeData: Int) {
        userSelectedPomodoroMins = pomodoroTimeData
        resetPomodoroMins()
        updatePomodoroMinsAndSecsLabel()
        enablePlay()
        pomodoroSeriesReady()
    }
    
}

extension PomodoroVC: ShortBreakTimeDelegate {
    
    func passShortBreakTimeData(shortBreakTimeData: Int) {
        userSelectedShortBreakMins = shortBreakTimeData
        resetShortBreakMins()
        enablePlay()
        pomodoroSeriesReady()
    }
    
}
 
extension PomodoroVC: LongBreakTimeDelegate {
    
    func passLongBreakTimeData(longBreakTimeData: Int) {
        userSelectedLongBreakMins = longBreakTimeData
        resetLongBreakMins()
        enablePlay()
        pomodoroSeriesReady()
    }

}

extension PomodoroVC: PomodorosInSetDelegate {
    
    func passPomdorosInSetData(pomodorosInSetData: Int) {
        userSelectedPomodoroNumber = pomodorosInSetData
        enablePlay()
        pomodoroSeriesReady()
    }
    
}
