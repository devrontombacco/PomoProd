//
//  ViewController.swift
//  PomoProd
//
//  Created by Devron Tombacco on 11/12/2020.
//

import UIKit

class PomodoroVC: UIViewController {
    
    // MARK:-- Variables
    var mins: Int = 25
    var secs: Int = 0
    var pomodoroTimer: Timer?
    var currentPomodoro: Int = 1
    var totalPomodoros: Int = 1
    
    // MARK:-- Outlets
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var pomodoroCountLabel: UILabel!
    
    override func viewDidLoad() {
        highlightCountLabel()
        updatePomorodoCountLabel()
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
    
    @IBAction func stopButtonTapped(_ sender: UIButton) {
        stopCountDown()
    }
    
    
    // MARK:-- Methods
    func highlightCountLabel(){
        
        pomodoroCountLabel.layer.borderWidth = 1
        pomodoroCountLabel.layer.borderColor = K.color.highlighted
        
    }
    
    func startCountDown(){
        print("Countdown started with \(mins):\(secs)")
        pomodoroTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PomodoroVC.countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown(){ 
        
        if secs == 0 && mins == 0 {
            
            // Stop timer when count down has finished
            pomodoroTimer?.invalidate()
            print("Timer invalidated")
            }
            else if secs > 0 {
                // decrement seconds by one
                secs = secs - 1
            }
            else if secs == 0 {
                // when secs get to 0, decrement mins
                mins = mins - 1
                secs = 59
            }
            
            updateMinsLabel()
            print("\(mins) \(secs)")
            }
    
    private func updateMinsLabel(){
        minutesLabel.text = "\(mins)"
        secondsLabel.text = "\(secs)"
    }
    
    private func updatePomorodoCountLabel(){
        pomodoroCountLabel.text! = "Pomodoro  \(currentPomodoro)/\(totalPomodoros)"
    }
    
    func stopCountDown(){
        pomodoroTimer?.invalidate()
        print("Timer invalidated at: \(mins) \(secs)")
    }

}

extension PomodoroVC: PomodoroTimeDelegate {
    
    func passPomodoroTimeData(pomodoroTimeData: Int) {
        mins = pomodoroTimeData
        secs = 0
        updateMinsLabel()
    }
    
}

extension PomodoroVC: ShortBreakTimeDelegate {
    
    func passShortBreakTimeData(shortBreakTimeData: Int) {
        secs = 0
    }
    
}
 
extension PomodoroVC: LongBreakTimeDelegate {
    
    func passLongBreakTimeData(longBreakTimeData: Int) {
        secs = 0
    }

}

extension PomodoroVC: PomodorosInSetDelegate {
    
    func passPomdorosInSetData(pomodorosInSetData: Int) {
        totalPomodoros = pomodorosInSetData
        updatePomorodoCountLabel()
    }
    
}
