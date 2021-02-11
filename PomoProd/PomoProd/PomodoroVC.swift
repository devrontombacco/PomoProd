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
    var secs: Int = 6
    var myTimer = Timer()
    
    // MARK:-- Outlets
    @IBOutlet weak var minutesLabel: UILabel!
    @IBOutlet weak var secondsLabel: UILabel!
    @IBOutlet weak var playButtonLabel: UIButton!
    
    // MARK:-- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        SettingsVC().pomodoroTimeDelegate = self
    }

    // MARK:-- IBActions
    @IBAction func playButtonTapped(_ sender: UIButton) {
        startCountDown()
    }
    
    // MARK:-- Methods
    func startCountDown(){
        print("Play button pressed. Countdown started")
        print("Timer is starting at \(mins)")
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDown), userInfo: nil, repeats: true)
    }
    
    @objc func countDown(){
        
        var minutes = mins
        var seconds = secs
        
            // decrement seconds by one
            if seconds > 0 {
                self.secs = self.secs - 1
            }
            // when secs get to 0, decrement mins
            else if seconds == 0 {
                minutes = minutes - 1
                seconds = 59
            }
            // Stop timer when count down has finished
            else if minutes == 0 && seconds == 0 {
                myTimer.invalidate()
            }
        self.updateLabel()
    }
    
    private func updateLabel(){
        minutesLabel.text = "\(mins)"
        secondsLabel.text = "\(secs)"
    }

}

    // MARK:-- PomodoroTimeDelegate
extension PomodoroVC: PomodoroTimeDelegate {
    
    func userSelectedTime(time: String) {
        mins = Int(time) ?? 3
    }
    
}
