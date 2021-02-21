//
//  SettingsVC.swift
//  PomoProd
//
//  Created by Devron Tombacco on 19/12/2020.
//

import UIKit

    // MARK:-- Protocols
protocol PomodoroTimeDelegate {
    func passData(pomodoroTimeData: Int)
}

protocol ShortBreakTimeDelegate {
    func passData(shortBreakTimeData: Int)
}

protocol LongBreakTimeDelegate {
    func passData(longBreakTimeData: Int)
}

protocol PomodorosInSetDelegate {
    func passData(pomodorosInSetData: Int)
}

class SettingsVC: UIViewController {
    
    // MARK:-- Variables
    var pomodoroTimePickerSelection: Int?
    var shortBreakTimePickerSelection: Int?
    var longBreakTimePickerSelection: Int?
    var pomodorosInSetPickerSelection: Int?
    
    
    // MARK:-- Delegates
    var pomodoroTimeDelegate: PomodoroTimeDelegate!
    var shortBreakTimeDelegate: PomodoroTimeDelegate!
    var longBreakTimeDelegate: PomodoroTimeDelegate!
    var pomodorosInSetDelegate: PomodoroTimeDelegate!
    
    
    // MARK:-- IBOutlets - Buttons
    @IBOutlet weak var InstructionsButtonOutlet: UIButton!
    @IBOutlet weak var exitButton: UIButton!

    
    
    // MARK:-- IBOutlets - Views
    @IBOutlet weak var pomodoroTimeView: UIView!
    @IBOutlet weak var shortBreakTimeView: UIView!
    @IBOutlet weak var longBreakTimeView: UIView!
    @IBOutlet weak var pomodorosInSetView: UIView!
    
    
    // MARK:-- IBOutlet - Labels
    @IBOutlet weak var pomodoroTimeLabel: UILabel!
    @IBOutlet weak var shortBreakMinsLabel: UILabel!
    @IBOutlet weak var longBreakTimeLabel: UILabel!
    @IBOutlet weak var pomodorosInSetLabel: UILabel!
    @IBOutlet weak var pomodoroTimeRecommendedLabel: UILabel!
    @IBOutlet weak var shortBreakTimeRecommendedLabel: UILabel!
    @IBOutlet weak var longBreakTimeRecommendedLabel: UILabel!
    @IBOutlet weak var pomodorosInSetRecommendedLabel: UILabel!
    
    
    // MARK:-- IBOutlet - PickerViews
    @IBOutlet weak var pomodoroTimePicker: UIPickerView!
    @IBOutlet weak var shortBreakTimePicker: UIPickerView!
    @IBOutlet weak var longBreakTimePicker: UIPickerView!
    @IBOutlet weak var pomodorosInSetPicker: UIPickerView!
    
    
    // MARK:-- DATA ARRAYS
    let pomodoroTimeArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,
        21,22,23,24,25]
    let shortBreakTimeArray = [1,2,3,4,5]
    let longBreakTimeArray = [10,11,12,13,14,15]
    let pomodorosInSetArray = [1,2,3,4,5]
    
    // MARK:-- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add Corner Radius to views
        InstructionsButtonOutlet.layer.cornerRadius = 25
        pomodoroTimeView.layer.cornerRadius = 25
        shortBreakTimeView.layer.cornerRadius = 25
        longBreakTimeView.layer.cornerRadius = 25
        pomodorosInSetView.layer.cornerRadius = 25
        
        // Add shadows to views
        configureShadows()
        
        // Add highlighted border to views
        configureBorders()
        
        // Configure Picker Views
        pomodoroTimePicker.delegate = self
        pomodoroTimePicker.dataSource = self
        shortBreakTimePicker.delegate = self
        shortBreakTimePicker.dataSource = self
        longBreakTimePicker.delegate = self
        longBreakTimePicker.dataSource = self
        pomodorosInSetPicker.delegate = self
        pomodorosInSetPicker.dataSource = self

    }

    // MARK:-- @IBActions
    @IBAction func exitButtonTapped(_ sender: UIButton) {
        
            dismiss(animated: true, completion: nil)
        
    }
    
    
    // MARK:-- Methods
    func configureShadows(){
        
        InstructionsButtonOutlet.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        InstructionsButtonOutlet.layer.shadowOpacity = 0.16
        InstructionsButtonOutlet.layer.shadowOffset = .init(width: 10, height: 10)
        InstructionsButtonOutlet.layer.shadowRadius = 4
        
        pomodoroTimeView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        pomodoroTimeView.layer.shadowOpacity = 0.16
        pomodoroTimeView.layer.shadowOffset = .init(width: 10, height: 10)
        pomodoroTimeView.layer.shadowRadius = 4
        
        
        shortBreakTimeView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        shortBreakTimeView.layer.shadowOpacity = 0.16
        shortBreakTimeView.layer.shadowOffset = .init(width: 10, height: 10)
        shortBreakTimeView.layer.shadowRadius = 4
        
        
        longBreakTimeView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        longBreakTimeView.layer.shadowOpacity = 0.16
        longBreakTimeView.layer.shadowOffset = .init(width: 10, height: 10)
        longBreakTimeView.layer.shadowRadius = 4
        
        
        pomodorosInSetView.layer.shadowColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 16.0).cgColor
        pomodorosInSetView.layer.shadowOpacity = 0.16
        pomodorosInSetView.layer.shadowOffset = .init(width: 10, height: 10)
        pomodorosInSetView.layer.shadowRadius = 4
        

    }
    
    func configureBorders(){
        
        InstructionsButtonOutlet.layer.borderWidth = 1
        InstructionsButtonOutlet.layer.borderColor = K.color.highlighted
        
        pomodoroTimeView.layer.borderWidth = 1
        pomodoroTimeView.layer.borderColor = K.color.highlighted
        
        shortBreakTimeView.layer.borderWidth = 1
        shortBreakTimeView.layer.borderColor = K.color.highlighted
        
        longBreakTimeView.layer.borderWidth = 1
        longBreakTimeView.layer.borderColor = K.color.highlighted
        
        pomodorosInSetView.layer.borderWidth = 1
        pomodorosInSetView.layer.borderColor = K.color.highlighted
        
    }
    
    func configureInstructionsButton(){
        InstructionsButtonOutlet.titleEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
    }
    
}

extension SettingsVC: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView {
        case pomodoroTimePicker:
            return pomodoroTimeArray.count
        case shortBreakTimePicker:
            return shortBreakTimeArray.count
        case longBreakTimePicker:
            return longBreakTimeArray.count
        default:
            return pomodorosInSetArray.count
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView {
        case pomodoroTimePicker:
            return String(pomodoroTimeArray[row])
        case shortBreakTimePicker:
            return String(shortBreakTimeArray[row])
        case longBreakTimePicker:
            return String(longBreakTimeArray[row])
        default:
            return String(pomodorosInSetArray[row])
        }
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView {
        case pomodoroTimePicker:
             print("pomodoroTimePicker: \(Int(pomodoroTimeArray[row]))")
             pomodoroTimeDelegate.passData(pomodoroTimeData: Int(pomodoroTimeArray[row]))
        case shortBreakTimePicker:
             print("shortBreakTimePicker: \(Int(shortBreakTimeArray[row]))")
             shortBreakTimeDelegate.passData(pomodoroTimeData: Int(shortBreakTimeArray[row]))
        case longBreakTimePicker:
             print("longBreakTimePicker: \(Int(longBreakTimeArray[row]))")
            longBreakTimeDelegate.passData(pomodoroTimeData: Int(longBreakTimeArray[row]))
        default:
             print("pomodorosInSetPicker: \(Int(pomodorosInSetArray[row]))")
             pomodorosInSetDelegate.passData(pomodoroTimeData: Int(pomodorosInSetArray[row]))
        }
    }
    
}
