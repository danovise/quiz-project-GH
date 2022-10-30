//
//  AppDelegate.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit
//import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      //  configureFirebase()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let authVC = ScreenFactoryImpl().makeAuthScreen()
        let navigationController = UINavigationController(rootViewController: authVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
    
//    func configureFirebase() {
//        FirebaseApp.configure()
//    }
}


