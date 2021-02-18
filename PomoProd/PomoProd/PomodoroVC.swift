//
//  ViewController.swift
//  PomoProd
//
//  Created by Devron Tombacco on 11/12/2020.
//

import UIKit

class PomodoroVC: UIViewController {
    
    // MARK:-- Variables
    var mins: Int = 0
    var secs: Int = 0
    var pomodoroTimer: Timer?
    
    // MARK:-- Outlets
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    
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
            
            updateLabel()
            print("\(mins) \(secs)")
            }
    
    private func updateLabel(){
        minutesLabel.text = "\(mins)"
        secondsLabel.text = "\(secs)"
    }
    
    func stopCountDown(){
        pomodoroTimer?.invalidate()
        print("Timer invalidated at: \(mins) \(secs)")
    }

}

extension PomodoroVC: PomodoroTimeDelegate, ShortBreakTimeDelegate, LongBreakTimeDelegate, PomodorosInSetDelegate {
    func passData(pomodoroTimeData: Int) {
        print("Data passed from SettingsVC = \(pomodoroTimeData)")
        mins = pomodoroTimeData
        updateLabel()
    }
    
    func passData(shortBreakTimeData: Int) {
        print("Data passed from SettingsVC = \(shortBreakTimeData)")
    }
    
    func passData(longBreakTimeData: Int) {
        print("Data passed from SettingsVC = \(longBreakTimeData)")
    }
    
    func passData(pomodorosInSetData: Int) {
        print("Data passed from SettingsVC = \(pomodorosInSetData)")
    }
    
}
