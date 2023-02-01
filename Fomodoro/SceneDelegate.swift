//
//  SceneDelegate.swift
//  Fomodoro
//
//  Created by 남경민 on 2022/11/29.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        setRootViewController(scene)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        callBackgroundImage(false)
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        
        callBackgroundImage(true)
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        
        callBackgroundImage(false)
        
        guard let start = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else { return }
        print("sceneWillEnterForeground", Date())
        let interval = Int(Date().timeIntervalSince(start))
        NotificationCenter.default.post(name: NSNotification.Name("sceneWillEnterForeground"), object: nil, userInfo: ["time" : interval])
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        
        callBackgroundImage(true)
        NotificationCenter.default.post(name: NSNotification.Name("sceneDidEnterBackground"), object: nil)
        UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
        print("sceneDidEnterBackground", Date())
    }
    
    func callBackgroundImage(_ bShow: Bool) {
        
        let TAG_BG_IMG = -101

        let backgroundView = window?.rootViewController?.view.window?.viewWithTag(TAG_BG_IMG)

        if bShow {

            if backgroundView == nil {

                //여기서 보여주고 싶은 뷰 자유롭게 생성
                let bgView = UIView()
                bgView.frame = UIScreen.main.bounds
                bgView.tag = TAG_BG_IMG
                bgView.backgroundColor = .black

                //bgView.addSubview(lbl)

                window?.rootViewController?.view.window?.addSubview(bgView)
            }
        } else {

            if let backgroundView = backgroundView {
                backgroundView.removeFromSuperview()
            }
        }
    }
}

extension SceneDelegate {
    private func setRootViewController(_ scene: UIScene){
        if Storage.isFirstTime() {
            setRootViewController(scene, name: "Onboarding",
                                  identifier: "OnboardingViewController")
        } else {
            setRootViewController(scene, name: "Main",
                                  identifier: "PageViewController")
        }
    }
    
    private func setRootViewController(_ scene: UIScene, name: String, identifier: String) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let storyboard = UIStoryboard(name: name, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: identifier)
            window.rootViewController = viewController
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
