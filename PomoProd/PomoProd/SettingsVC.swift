//
//  SettingsVC.swift
//  PomoProd
//
//  Created by Devron Tombacco on 19/12/2020.
//

import UIKit

class SettingsVC: UIViewController {
    
    // Button
    @IBOutlet weak var InstructionsButtonOutlet: UIButton!
    
    // Views
    @IBOutlet weak var PomodoroTimeView: UIView!
    @IBOutlet weak var ShortBreakTimeView: UIView!
    @IBOutlet weak var LongBreakTimeView: UIView!
    @IBOutlet weak var PomodorosInSetView: UIView!
    
    // TextFields
    @IBOutlet weak var pomodoroTimeTextField: UITextField!
    @IBOutlet weak var shortBreakTextField: UITextField!
    @IBOutlet weak var longBreakTextField: UITextField!
    @IBOutlet weak var pomodorosInSetTextField: UITextField!
    
    var activeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Add Corner Radius to views
        InstructionsButtonOutlet.layer.cornerRadius = 25
        PomodoroTimeView.layer.cornerRadius = 25
        ShortBreakTimeView.layer.cornerRadius = 25
        LongBreakTimeView.layer.cornerRadius = 25
        PomodorosInSetView.layer.cornerRadius = 25
        
        // Add shadows to views
        configureShadows()
        
        // Assign textfield delegates
        pomodoroTimeTextField.delegate = self
        shortBreakTextField.delegate = self
        longBreakTextField.delegate = self
        pomodorosInSetTextField.delegate = self
        
        // Change return key
        pomodoroTimeTextField.returnKeyType = .done
        shortBreakTextField.returnKeyType = .done
        longBreakTextField.returnKeyType = .done
        pomodorosInSetTextField.returnKeyType = .done
        
        pomodorosInSetTextField.tag = 1
        
        // Raise content above keyboard for pomodorosInSetTextField
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

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

extension SettingsVC: UITextFieldDelegate {
        
    // MARK:-- TextField Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    // Dismiss keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) ->   Bool {
        
        switch textField {
        case pomodoroTimeTextField:
            pomodoroTimeTextField.resignFirstResponder()
        case shortBreakTextField:
            shortBreakTextField.resignFirstResponder()
        case longBreakTextField:
            longBreakTextField.resignFirstResponder()
        default:
            pomodorosInSetTextField.resignFirstResponder()
        }
        return true
    }
    
    // Raise content when keyboard is in view
    @objc func keyboardWillShow(notification: NSNotification) {
        if activeTextField == pomodorosInSetTextField {
            if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                if self.view.frame.origin.y == 0 {
                    self.view.frame.origin.y -= keyboardSize.height
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if activeTextField == pomodorosInSetTextField {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y = 0
            }
        }
    }
}
