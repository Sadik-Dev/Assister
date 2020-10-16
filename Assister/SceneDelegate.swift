//
//  SceneDelegate.swift
//  Assister
//
//  Created by Sana on 15/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }

        window?.rootViewController = createTabbar()
        
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginNavController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
                // if user is logged in before
                if let loggedUsername = UserDefaults.standard.string(forKey: "username") {
                    // instantiate the main tab bar controller and set it as root view controller
                    // using the storyboard identifier we set earlier
                    let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
                    window?.rootViewController = mainTabBarController
                } else {
                    // if user isn't logged in
                    // instantiate the navigation controller and set it as root view controller
                    // using the storyboard identifier we set earlier
                    window?.rootViewController = loginNavController
                }
        

       
    }

    func createTabbar() -> UITabBarController {
        
        let tabbar = UITabBarController()
        UITabBar.appearance().tintColor = .green
        UITabBar.setTransparentTabbar()
        tabbar.viewControllers = [createFirstVC(), createSecondVC()]
        
        return tabbar
    }
    
    func createFirstVC() -> FirstViewController{
        let viewController =   FirstViewController()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        return viewController
    }
    
    func createSecondVC() -> SecondViewController{
        let viewController =   SecondViewController()
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        return viewController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
       guard let window = self.window else {
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()

        UIView.transition(with: window,
                          duration: 0.5,
                          options: [.transitionFlipFromTop],
                          animations: nil,
                          completion: nil)
    }
}

