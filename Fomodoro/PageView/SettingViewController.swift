//
//  SettingViewController.swift
//  Fomodoro
//
//  Created by 남경민 on 2022/11/29.
//

import UIKit

protocol SettingDelegate {
    func focusSend(focus: Int)
    func shortSend(short: Int)
    func longSend(long: Int)
}

class SettingViewController: UIViewController {
    
    var delegate : SettingDelegate?
    
    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    let maxItem = 12 // 최대 선택 개수
    let pickerViewCnt = 1 // 피커뷰 열의 개수
    var settingTimeName = [5,10,15,20,25,30,35,40,45,50,55,60]
    
    var time = 0
    var focusTime = 0 {
        didSet {
            focusLabel.text = String(focusTime)
            //delegate?.focusSend(focus: focusTime)
            //self.navigationController?.popViewController(animated: true)
        }
    }
    var shortBreakTime = 0 {
        didSet {
            shortBreakLabel.text = String(shortBreakTime)
        }
    }
    var longBreakTime = 0 {
        didSet {

            longBreakLabel.text = String(longBreakTime)
        }
    }

    
    @IBOutlet weak var focusLabel: UILabel!
    @IBOutlet weak var shortBreakLabel: UILabel!
    @IBOutlet weak var longBreakLabel: UILabel!
    
    @IBOutlet weak var focusButton: UIButton!
    @IBOutlet weak var shortBreakButton: UIButton!
    @IBOutlet weak var longBreakButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bringSubviewToFront(focusButton)
        self.view.bringSubviewToFront(shortBreakButton)
        self.view.bringSubviewToFront(longBreakButton)
        
    }
    
    @IBAction func focusButtonTapped(_ sender: Any) {
        createPickerView("focusTime")
        
    }
    @IBAction func shortBreakButtonTapped(_ sender: Any) {
        createPickerView("shortBreakTime")
        
    }
    @IBAction func longBreakButtonTapped(_ sender: Any) {
        createPickerView("longBreakTime")
        
    }
    
    // pickerview 생성
    func createPickerView(_ timeName: String) {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.black
        picker.setValue(UIColor.white, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .blackTranslucent
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
        
        if timeName == "focusTime" {
            focusTime = time
        } else if timeName == "shortBreakTime" {
            shortBreakTime = time
            
        } else if timeName == "longBreakTime" {
            longBreakTime = time
        }
        
        let vc = self.presentingViewController as? TimerViewController // ①
        
        vc?.focusTime = self.focusTime
        vc?.shortBreakTime = self.shortBreakTime
        vc?.longBreakTime = self.longBreakTime
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
     }
    
    
    @objc func onDoneButtonTapped() {
        self.view.endEditing(true)
    }

    
}

extension SettingViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 피커뷰 열의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewCnt
    }
    
    // 피커뷰에서 선택할 수 있는 아이템 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settingTimeName.count
    }

    // 피커뷰에 각 아이템 명칭을 넘김
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(settingTimeName[row])
    }
    
    // 아이템을 선택한 후 실행할 동작
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        time = settingTimeName[row]
    }
    
    // 피커뷰 text color
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: String(settingTimeName[row]), attributes: [.foregroundColor:UIColor.white])
    }
    
}
