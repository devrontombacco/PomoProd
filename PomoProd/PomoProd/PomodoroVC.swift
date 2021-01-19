//
//  ViewController.swift
//  PomoProd
//
//  Created by Devron Tombacco on 11/12/2020.
//

import UIKit

class PomodoroVC: UIViewController {

    var mins: Int = 0
    var secs: Int = 6
    
    var myTimer = Timer()
    
    @IBOutlet weak var minutesLabel: UILabel!
    
    @IBOutlet weak var secondsLabel: UILabel!
    
    @IBOutlet weak var playButtonLabel: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        startCountDown()
    }
    
    func startCountDown(){
        print("Play button pressed. Countdown started")
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


/*
 
 
 timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
     
     while self.mins > 0 && self.secs > 0 {
         // decrement seconds by one
         if self.secs > 0 {
             self.secs = self.secs - 1
         }
         // when secs get to 0, decrement mins
         else if self.secs == 0 {
             self.mins = self.mins - 1
             self.secs = 59
         }
         // when mins & secs get to 0, notify me in console
         // && self.secs == 0
         else if self.mins == 0 && self.secs == 0{
             // self.timer.invalidate()
             break
         }
         print("Countdown finished ")
         // update label
         self.updateLabel()
     }
 })
 
 
 
 
 
 
 
 
 
 
 SWITCH STATEMENT
 ------------------
 let countDownSeconds = self.secs
 let countDownMinutes = self.mins
 switch (countDownSeconds, countDownMinutes) {
     case (1...59, 1...59):
         self.secs = self.secs - 1
     case (0, 1...59):
         self.mins = self.mins - 1
         self.secs = 59
     case (0, 0):
         break
     default:
         break
     }
 self.updateLabel()
 
 */
