//
//  AppDelegate.swift
//  HyperPPDemo
//
//  Created by Harshit Srivastava on 20/04/22.
//  Copyright © 2022 Juspay Technologies. All rights reserved.
//

import UIKit
import HyperSDK

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let clientId = "geddit"

        var innerPayload : [String:Any] = [:]
        innerPayload["clientId"] = clientId

        let payload = [
           "payload" : innerPayload,
           "service" : "in.juspay.hyperpay"
        ] as [String: Any]
              
        // Prefetch
        HyperServices.preFetch(payload)
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

