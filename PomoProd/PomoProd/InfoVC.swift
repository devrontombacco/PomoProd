//
//  InfoVC.swift
//  PomoProd
//
//  Created by Devron Tombacco on 19/12/2020.
//

import UIKit

class InfoVC: UIViewController {

    @IBOutlet weak var instructionsContainerView: UIView!
    @IBOutlet weak var instructionsTitleLabel: UILabel!
    @IBOutlet weak var pomodoroPanel: UIView!
    @IBOutlet weak var shortBreakPanel: UIView!
    @IBOutlet weak var longBreakPanel: UIView!
    @IBOutlet weak var productivityPanel: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        instructionsContainerView.layer.cornerRadius = 25
        pomodoroPanel.layer.cornerRadius = 25
        shortBreakPanel.layer.cornerRadius = 25
        longBreakPanel.layer.cornerRadius = 25
        productivityPanel.layer.cornerRadius = 25
        configureShadows()
    }
    
    func configureShadows(){
        
        pomodoroPanel.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        pomodoroPanel.layer.shadowOpacity = 0.16
        pomodoroPanel.layer.shadowOffset = .init(width: 10, height: 10)
        pomodoroPanel.layer.shadowRadius = 4
        
        shortBreakPanel.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        shortBreakPanel.layer.shadowOpacity = 0.16
        shortBreakPanel.layer.shadowOffset = .init(width: 10, height: 10)
        shortBreakPanel.layer.shadowRadius = 4
        
        longBreakPanel.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        longBreakPanel.layer.shadowOpacity = 0.16
        longBreakPanel.layer.shadowOffset = .init(width: 10, height: 10)
        longBreakPanel.layer.shadowRadius = 4
        
        productivityPanel.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        productivityPanel.layer.shadowOpacity = 0.16
        productivityPanel.layer.shadowOffset = .init(width: 10, height: 10)
        productivityPanel.layer.shadowRadius = 4
        
    }

}
