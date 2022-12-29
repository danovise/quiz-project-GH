//
//  PersonalScoreVC.swift
//  quiz-project
//
//  Created by Daria Sechko on 27.11.22.
//

import UIKit

final class PersonalScoreVC: UIViewController {
    
    lazy var totalScoreHeader = ScoreHeaderView()
    
    var scoreArchiver = ScoreArchiverImpl()

    var scoreModel: Score?
    
    var scores: [Score] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    lazy var homeBarButton: UIBarButtonItem = {
        let image = UIImage(systemName: "house.fill")
        let button = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(homeBarButtonAction))
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        
        var table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(ScoreCell.self, forCellReuseIdentifier: ScoreCell.reuseId)
        
        return table
    }()
    
    init(model: Score) {
        super.init(nibName: nil, bundle: nil)
        scoreModel = model
        //читаем поэтапно
        scores = scoreArchiver.retrieve()
        scores.insert(model, at: 0)
        scoreArchiver.save(scores)
        totalScoreHeader.configure(totalScore: model.correctQuestionIds.count)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstrains()
    }
    //MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = homeBarButton
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
    }
    
    private func setupConstrains() {
        
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    // MARK: - Actions
    @objc
    func homeBarButtonAction() {
        let mainVC = ScreenFactoryImpl().makeMainScreen()
        navigationController?.pushViewController(mainVC, animated: true)
    }
}

//MARK: - UITableViewDataSource
extension PersonalScoreVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreCell.reuseId, for: indexPath) as? ScoreCell else { return UITableViewCell() }
        
        let score = scores[indexPath.row]
        cell.configure(score)
        
        return cell
    }
}
//MARK: - UITableViewDelegate
extension PersonalScoreVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return totalScoreHeader
    }
}

