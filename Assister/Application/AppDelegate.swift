//
//  AppDelegate.swift
//  Assister
//
//  Created by Sana on 15/10/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        // Show notifications also when app is in foreground
        UNUserNotificationCenter.current().delegate = self as! UNUserNotificationCenterDelegate

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        application.registerUserNotificationSettings(UIUserNotificationSettings(types: UIUserNotificationType(rawValue: UIUserNotificationType.sound.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.alert.rawValue), categories: nil))

        return true
    }

    func userNotificationCenter(
           _ center: UNUserNotificationCenter,
           willPresent notification: UNNotification,
           withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions)
           -> Void) {
           completionHandler([.alert, .badge, .sound])
       }

}
