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
        
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.showStandardGameScreen()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .cyan
        navigationItem.hidesBackButton = true
    }
    
    private func setupConstraints() {
        
    }
    
    //MARK: - Navigation
    func showStandardGameScreen() {
        
        let gameVC = ScreenFactoryImpl().makeStandardGameScreen()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}
