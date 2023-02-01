//
//  OnboardingViewController.swift
//  Fomodoro
//
//  Created by 남경민 on 2022/12/03.
//

import UIKit

class OnboardingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
     
     private func presentMainVC() {
         let storyboard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyboard.instantiateViewController(withIdentifier: "PageViewController") as! PageViewController
         vc.modalPresentationStyle = .fullScreen
         present(vc, animated: false, completion: nil)
     }
    
    @IBAction func buttonTapped(_ sender: Any) {
        presentMainVC()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
