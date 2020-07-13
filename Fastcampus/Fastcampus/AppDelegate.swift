//
//  AppDelegate.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/13.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    FirebaseApp.configure()
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = MainVC()
    window?.makeKeyAndVisible()
    return true
  }
}
