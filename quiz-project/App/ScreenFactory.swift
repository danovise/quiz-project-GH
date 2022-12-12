//
//  ScreenFactory.swift
//  quiz-project
//
//  Created by Daria Sechko on 30.10.22.
//

import Foundation

protocol ScreenFactory {
    
    func makeStandardGameScreen() -> GameVC
    func makeFastGameScreen() -> FastGameVC
    func makeAuthScreen() -> AuthVC
    func makeMainScreen() -> MainVC
}

class ScreenFactoryImpl: ScreenFactory {
    
    func makeStandardGameScreen() -> GameVC {
        
        let questionProvider = QuestionsProviderImpl.shared
        let gameVC = GameVC(questionProvider: questionProvider)
        
        return gameVC
    }
    
    func makeFastGameScreen() -> FastGameVC {
        
        let questionProvider = QuestionsProviderImpl.shared
        let fastGameVC = FastGameVC(questionProvider: questionProvider)
        
        return fastGameVC
    }
    
    func makeAuthScreen() -> AuthVC {
        
        let authVC = AuthVC()
        return authVC
    }
    
    func makeMainScreen() -> MainVC {
        
        let mainVC = MainVC()
        return mainVC
    }
}
