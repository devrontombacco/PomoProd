//
//  ViewController.swift
//  PomoProd
//
//  Created by Devron Tombacco on 11/12/2020.
//

import UIKit

class PomodoroVC: UIViewController {

    var testPass: String = ""
    
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
        SettingsVC().pomodoroTimeDelegate = self
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

extension PomodoroVC: PomodoroTimeDelegate {
    
    func userSelectedTime(time: String) {
        testPass = time
        print("the value of testPass is \(testPass)")
    }
    
}

/*
 let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
         secondVC.selectionDelegate = self
         present(secondVC, animated: true, completion: nil)
 */
