//
//  InfoVC.swift
//  PomoProd
//
//  Created by Devron Tombacco on 19/12/2020.
//

import UIKit

class InfoVC: UIViewController {

    // Container
    @IBOutlet weak var instructionsContainerView: UIView!
    
    // Title
    @IBOutlet weak var instructionsTitleLabel: UILabel!
    
    // Panels
    @IBOutlet weak var pomodoroPanel: UIView!
    @IBOutlet weak var shortBreakPanel: UIView!
    @IBOutlet weak var longBreakPanel: UIView!
    @IBOutlet weak var productivityPanel: UIView!
    
    // Labels
    @IBOutlet weak var pomodoPanelLabel: UILabel!
    @IBOutlet weak var shortBreakPanelLabel: UILabel!
    @IBOutlet weak var longBreakPanelLabel: UILabel!
    @IBOutlet weak var productivityPanelLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        instructionsContainerView.layer.cornerRadius = 25
        pomodoroPanel.layer.cornerRadius = 25
        shortBreakPanel.layer.cornerRadius = 25
        longBreakPanel.layer.cornerRadius = 25
        productivityPanel.layer.cornerRadius = 25
        configureShadows()
        
        configurePanelTextColors()
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

    func configurePanelTextColors(){

        let pomodoroHighlight = "A pomodoro is a unit of time, typically 25 minutes, that you work for without any breaks"
        let pomodoroHighlightAttributedString = NSMutableAttributedString(string: pomodoroHighlight)
        pomodoroHighlightAttributedString.addAttribute(.foregroundColor, value: K.color.highlighted, range: NSRange(location: 2, length: 8))
        pomodoPanelLabel.attributedText = pomodoroHighlightAttributedString
        
        let shortBreakHighlight = "Between each pomodoro you may take a short break (it is recommended not to do longer than 5 minutes)"
        let shortBreakHighlightAttributedString = NSMutableAttributedString(string: shortBreakHighlight)
        shortBreakHighlightAttributedString.addAttribute(.foregroundColor, value: K.color.highlighted, range: NSRange(location: 36, length: 12))
        shortBreakPanelLabel.attributedText = shortBreakHighlightAttributedString
        
            
        let longBreakHighlight = "After a series of pomodoros (usually 3 or 4), you can then take a long break for about 25 minutes"
        let longBreakHighlightAttributedString = NSMutableAttributedString(string: longBreakHighlight)
        longBreakHighlightAttributedString.addAttribute(.foregroundColor, value: K.color.highlighted, range: NSRange(location: 66, length: 10))
        longBreakPanelLabel.attributedText = longBreakHighlightAttributedString
        
        let productiveHighlight = "These short bursts of focus prove to be much more productive in the long run!"
        let productiveHighlightAttributedString = NSMutableAttributedString(string: productiveHighlight)
        productiveHighlightAttributedString.addAttribute(.foregroundColor, value: K.color.highlighted, range: NSRange(location: 50, length: 10))
        productivityPanelLabel.attributedText = productiveHighlightAttributedString
    
    }
    
}
