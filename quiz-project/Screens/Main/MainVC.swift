//
//  MainVC.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemMint
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showStandardGameScreen()
        }
    }
    
    //MARK: - Navigation
    func showStandardGameScreen() {
        
        let gameVC = ScreenFactoryImpl().makeStandardGameScreen()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
