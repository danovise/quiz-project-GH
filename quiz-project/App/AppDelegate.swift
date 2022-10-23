//
//  AppDelegate.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let jsonService = JsonServiceImpl()
        let questionProvider = QuestionsProviderImpl(jsonService: jsonService)
        let gameVC = GameVC(questionProvider: questionProvider) //Dependency injection -> через инициализатор
        
        window?.rootViewController = gameVC
        window?.makeKeyAndVisible()
        
        return true
    }

}


