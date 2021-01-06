//
//  SettingsVC.swift
//  PomoProd
//
//  Created by Devron Tombacco on 19/12/2020.
//

import UIKit

class SettingsVC: UIViewController {
    
    @IBOutlet weak var InstructionsButtonOutlet: UIButton!
    @IBOutlet weak var PomodoroTimeView: UIView!
    @IBOutlet weak var ShortBreakTimeView: UIView!
    @IBOutlet weak var LongBreakTimeView: UIView!
    @IBOutlet weak var PomodorosInSetView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        InstructionsButtonOutlet.layer.cornerRadius = 25
        PomodoroTimeView.layer.cornerRadius = 25
        ShortBreakTimeView.layer.cornerRadius = 25
        LongBreakTimeView.layer.cornerRadius = 25
        PomodorosInSetView.layer.cornerRadius = 25
        
        configureShadows()
        
    }

    @IBAction func InstructionsButton(_ sender: UIButton) {
        // segue code here
    }
    
    func configureShadows(){
        
        InstructionsButtonOutlet.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        InstructionsButtonOutlet.layer.shadowOpacity = 0.16
        InstructionsButtonOutlet.layer.shadowOffset = .init(width: 10, height: 10)
        InstructionsButtonOutlet.layer.shadowRadius = 4
        
        PomodoroTimeView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        PomodoroTimeView.layer.shadowOpacity = 0.16
        PomodoroTimeView.layer.shadowOffset = .init(width: 10, height: 10)
        PomodoroTimeView.layer.shadowRadius = 4
        
        ShortBreakTimeView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        ShortBreakTimeView.layer.shadowOpacity = 0.16
        ShortBreakTimeView.layer.shadowOffset = .init(width: 10, height: 10)
        ShortBreakTimeView.layer.shadowRadius = 4
        
        LongBreakTimeView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        LongBreakTimeView.layer.shadowOpacity = 0.16
        LongBreakTimeView.layer.shadowOffset = .init(width: 10, height: 10)
        LongBreakTimeView.layer.shadowRadius = 4
        
        PomodorosInSetView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        PomodorosInSetView.layer.shadowOpacity = 0.16
        PomodorosInSetView.layer.shadowOffset = .init(width: 10, height: 10)
        PomodorosInSetView.layer.shadowRadius = 4
    }
    
    func configureInstructionsButton(){
        InstructionsButtonOutlet.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    }
    
}
