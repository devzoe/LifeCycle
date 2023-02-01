//
//  MainViewController.swift
//  Fomodoro
//
//  Created by 남경민 on 2022/12/01.
//

import UIKit


class TimerViewController: UIViewController {
    // totalTime에 들어감
    var focusTime = 30
    var shortBreakTime = 10
    var longBreakTime = 20
    
    var startorstop = false
    
    //let chooseTime = ["FocusTime":30, "ShortBreak":10, "LongBreak": 20]
    var getTime = "FocusTime"

    var timer = Timer()

    var totalTime = 0

    var secondsPassed = 0
    var minutes = 0
    var seconds = 0

    
    var progressBar = KDCircularProgress(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
    
    let maxItem = 3 // 최대 선택 개수
    let pickerViewCnt = 1 // 피커뷰 열의 개수
    var timeName = ["FocusTime", "ShortBreak", "LongBreak"]
    
    @IBOutlet weak var playButton: UIButton!
    
    @IBOutlet weak var timePickerView: UIPickerView! // 피커 뷰
    
    @IBOutlet weak var timeTextField: UITextField!
    @IBOutlet weak var timerLabel: UILabel!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        print("")
        print("===============================")
        print("[ViewController > viewDidLoad() : 뷰 로드 실시]")
        print("===============================")
        print("")
        timerLabel.alpha = 0
        
        // Do any additional setup after loading the view.
        //progressBar.alpha = 0
        progressBar.startAngle = -90
        progressBar.progressThickness = 0.2
        progressBar.trackThickness = 0.6
        progressBar.clockwise = true
        progressBar.gradientRotateSpeed = 2
        progressBar.roundedCorners = false
        progressBar.glowMode = .forward
        progressBar.glowAmount = 0.9
        progressBar.set(colors: UIColor.cyan ,UIColor.white, UIColor.magenta, UIColor.white, UIColor.orange)
        progressBar.center = CGPoint(x: view.center.x, y: view.center.y - 225)
        view.addSubview(progressBar)

        self.view.bringSubviewToFront(playButton)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("")
        print("===============================")
        print("[ViewController > viewWillAppear() : 뷰 화면 표시]")
        print("===============================")
        print("")
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("")
        print("===============================")
        print("[ViewController > viewDidAppear() : 뷰 화면 표시]")
        print("===============================")
        print("")
        
        setNotifications()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("")
        print("===============================")
        print("[ViewController > viewWillDisappear() : 뷰 정지 상태]")
        print("===============================")
        print("")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("")
        print("===============================")
        print("[ViewController > viewDidDisappear() : 뷰 종료 상태]")
        print("===============================")
        print("")
        
        // [뷰 컨트롤러 포그라운드, 백그라운드 상태 체크 해제 실시]
        NotificationCenter.default.removeObserver(self, name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    @IBAction func playButtonTapped(_ sender: UIButton) {
        startorstop = true
        timer.invalidate()
        
        if getTime == "FocusTime" {
            totalTime = focusTime
        } else if getTime == "ShortBreak" {
            totalTime = shortBreakTime
        } else if getTime == "LongBreak" {
            totalTime = longBreakTime
        }

        //let hardness = sender.currentTitle!
        //totalTime = chooseTime[getTime]! // 10초

        progressBar.progress = 0.0

        secondsPassed = 0
        
        self.playButton.alpha = 0
        self.timerLabel.alpha = 1

        //titleLabel.text = hardness

         

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }
 
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            minutes = (totalTime-secondsPassed) / 60
            seconds = (totalTime-secondsPassed) % 60
            progressBar.progress = Double(Float(secondsPassed) / Float(totalTime)) //이렇게 보내주면
            
            self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        
        } else {
            
            timer.invalidate()
            startorstop = false
            
            progressBar.progress = 0.0
            
            self.playButton.alpha = 1
            self.timerLabel.alpha = 0
            
            //titleLabel.text = "Done!"
            
            //playSound()
        }
        
    }
    
    func setNotifications() {
        //백그라운드에서 포어그라운드로 돌아올때
        NotificationCenter.default.addObserver(self, selector: #selector(addbackGroundTime(_:)), name: NSNotification.Name("sceneWillEnterForeground"), object: nil)
        //포어그라운드에서 백그라운드로 갈때
        NotificationCenter.default.addObserver(self, selector: #selector(stopTimer), name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
    }
    
    @objc func addbackGroundTime(_ notification:Notification) {
        if startorstop == true {
            //노티피케이션센터를 통해 값을 받아옴
            let time = notification.userInfo?["time"] as? Int ?? 0
            secondsPassed += time
            //setLottieAnimation(play: true)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.updateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @objc func stopTimer() {
        timer.invalidate()
    }
    
 
}

extension TimerViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    // 피커뷰 열의 개수
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerViewCnt
    }
    
    // 피커뷰에서 선택할 수 있는 아이템 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return timeName.count
    }

    // 피커뷰에 각 아이템 명칭을 넘김
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return timeName[row]
    }
    
    // 아이템을 선택한 후 실행할 동작
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getTime = timeName[row]
        timeTextField.text = getTime // text field에 넣기
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: self.timeName[row], attributes: [.foregroundColor:UIColor.white])
    }
    
    
    /*
    // 피커뷰 높이
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        <#code#>
    }
     */
    
}
