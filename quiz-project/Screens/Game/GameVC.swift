//
//  ViewController.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit
import SnapKit

enum QuestionSectionType: Int, CaseIterable {
    case question
    case answer
    case button
}

enum QuestionType: Int, CaseIterable {
    case text
    case image
}

class GameVC: UIViewController {
    
    var jsonService: JsonService
    
    var questions: [Question] = []
    
    var currentQuestion: Question? = nil
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.separatorStyle = .none
        
        tableView.register(QuestionTextCell.self, forCellReuseIdentifier: QuestionTextCell.reuseId)
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.reuseId)
        tableView.register(CheckButtonCell.self, forCellReuseIdentifier: CheckButtonCell.reuseId)
        
        tableView.tableHeaderView = headerLabel
        
        return tableView
    }()
    
    var headerLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 60))
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .gray
        label.text = "Question 1/10"
        return label
    }()
    
    //MARK: - Lifecycle
    
    init(jsonService: JsonService) {
        self.jsonService = jsonService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        fetchLocalQuestions()
        
    }
    
    //MARK: - Request
    private func fetchLocalQuestions() {
        questions = jsonService.loadJson(filename: "questions") ?? []
        currentQuestion = questions.randomElement()
        
        tableView.reloadData()
    }
    
    //MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
        view.backgroundColor = .red
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(tableView).inset(40)
        }
    }
}
//MARK: - UITableViewDataSource
extension GameVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return QuestionSectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let sectionType = QuestionSectionType.init(rawValue: section) {
            
            switch sectionType {
            case .question:
                return 1
            case .answer:
                return currentQuestion?.answers.count ?? 0
            case .button:
                return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let fullQuestion = questions[indexPath.section]
        
        if let sectionType = QuestionSectionType.init(rawValue: indexPath.section) {
            
            switch sectionType {
            case .question:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTextCell.reuseId, for: indexPath) as? QuestionTextCell else { return UITableViewCell() }
                cell.configure(currentQuestion)
                return cell
                
            case .answer:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.reuseId, for: indexPath) as? AnswerCell else { return UITableViewCell() }
                
                let answer = currentQuestion?.answers[indexPath.row]
                
                cell.configure(answer)
                
                return cell
                
            case .button:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckButtonCell.reuseId, for: indexPath) as? CheckButtonCell else { return UITableViewCell() }
                cell.configure(currentQuestion)
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
//MARK: - UITableViewDelegate
extension GameVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let fullQuestion = questions[indexPath.section]
        
        if let questionType = QuestionType.init(rawValue: indexPath.row) {
            switch questionType {
            case .text:
                return fullQuestion.text!.isEmpty ? 0 : UITableView.automaticDimension
            case .image:
                return fullQuestion.image!.isEmpty ? 0 : UITableView.automaticDimension
            default: return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
    
}
