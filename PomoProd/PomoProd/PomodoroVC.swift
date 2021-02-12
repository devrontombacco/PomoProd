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
    var secs: Int = 3
    var pomodoroTimer: Timer?
    
    // MARK:-- Outlets
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var playButtonLabel: UIButton!
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PresentSettingsVCSegue", let vc = segue.destination as? SettingsVC {
            vc.pomodoroTimeDelegate = self
        }
    }

    // MARK:-- IBActions
    @IBAction func playButtonTapped(_ sender: UIButton) {
        startCountDown()
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

}

    // MARK:-- PomodoroTimeDelegate
extension PomodoroVC: PomodoroTimeDelegate {

    func userSelectedTime(time: String) {
        mins = Int(time) ?? 25
        updateLabel()
    }

}
