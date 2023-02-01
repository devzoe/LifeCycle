//
//  PageViewController.swift
//  Fomodoro
//
//  Created by 남경민 on 2022/12/02.
//

import UIKit

class PageViewController: UIPageViewController {
    lazy var vcArray: [UIViewController] = {
        return [self.vcInstance(name: "TimerViewController"),
                self.vcInstance(name: "SettingViewController"),
                self.vcInstance(name: "TimeCountViewController")]
    }()
    private func vcInstance(name: String) -> UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: name)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        if let firstVC = vcArray.first {
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }

        // Do any additional setup after loading the view.
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

extension PageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        // 배열에서 현재 페이지의 컨트롤러를 찾아서 해당 인덱스를 현재 인덱스로 기록
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        // 이전 페이지 인덱스
        let prevIndex = vcIndex - 1
        
        // 인덱스가 0 이상이라면 그냥 놔둠
        guard prevIndex >= 0 else {
            return nil
            
            // 무한반복 시 - 1페이지에서 마지막 페이지로 가야함
            // return vcArray.last
        }
        
        // 인덱스는 vcArray.count 이상이 될 수 없음
        guard vcArray.count > prevIndex else { return nil }
        
        return vcArray[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = vcArray.firstIndex(of: viewController) else { return nil }
        
        // 다음 페이지 인덱스
        let nextIndex = vcIndex + 1
        
        guard nextIndex < vcArray.count else {
            return nil
            
            // 무한반복 시 - 마지막 페이지에서 1 페이지로 가야함
            // return vcArray.first
        }
        
        guard vcArray.count > nextIndex else { return nil }
        
        return vcArray[nextIndex]
    }
    
    public func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcArray.count
    }
    
    public func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first, let firstViewControllerIndex = vcArray.index(of: firstViewController) else{
            return 0
        }
        
        return firstViewControllerIndex
    }
    
}
