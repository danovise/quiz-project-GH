//
//  PersonalScoreVC.swift
//  quiz-project
//
//  Created by Daria Sechko on 27.11.22.
//

import UIKit

class PersonalScoreVC: UIViewController {
    
    lazy var tableView: UITableView = {
        
        var table = UITableView()
        table.dataSource = self
        table.register(ScoreCell.self, forCellReuseIdentifier: ScoreCell.reuseId)
        
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
    }
    
    func setupViews() {
        view.addSubview(tableView)
    }
    
    func setupConstrains() {
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
}

extension PersonalScoreVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.reuseId, for: indexPath) as? ScoreCell else { return UITableViewCell() }
        return cell
    }
}
