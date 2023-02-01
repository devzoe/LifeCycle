//
//  TimeCountViewController.swift
//  Fomodoro
//
//  Created by 남경민 on 2022/11/29.
//

import UIKit

class TimeCountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(ViewController.respondToSwipeGesture(_:)))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
        // Do any additional setup after loading the view.
         */
    }
    
    
    /*
    // 한 손가락 스와이프 제스쳐를 행했을 때 실행할 액션 메서드
    @objc func respondToSwipeGesture(_ gesture: UIGestureRecognizer) {
        // 만일 제스쳐가 있다면
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            

            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.left :
                let mainViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                mainViewController.modalPresentationStyle = .fullScreen
                self.present(mainViewController, animated: true, completion: nil)
            default:
                break
            }
            
        }
     */
}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


