//
//  GameVC.swift
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
    
    var questionProvider: QuestionsProvider
    
    lazy var questionNumberHeader = QuestionNumberHeader(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
    
    private lazy var tableView: UITableView = {
        var tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        
        tableView.register(QuestionTextCell.self, forCellReuseIdentifier: QuestionTextCell.reuseId)
        tableView.register(QuestionImageCell.self, forCellReuseIdentifier: QuestionImageCell.reuseId)
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.reuseId)
        tableView.register(CheckButtonCell.self, forCellReuseIdentifier: CheckButtonCell.reuseId)
        
        tableView.tableHeaderView = questionNumberHeader
        
        return tableView
    }()
 
    //MARK: - Lifecycle
    
    init(questionProvider: QuestionsProvider) {
        self.questionProvider = questionProvider
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
        
        questionProvider.fetchAllQuestions()
        let (_, number, count) = questionProvider.nextQuestion()
        
        questionNumberHeader.configure(currentQuestion: number, numberOfQuestions: count)
        tableView.reloadData()
    }
    
    //MARK: - Private
    private func setupViews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
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
            case .question: return QuestionType.allCases.count
            case .answer: return questionProvider.currentQuestion?.answers.count ?? 0
            case .button: return 1
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let sectionType = QuestionSectionType.init(rawValue: indexPath.section) {
            
            switch sectionType {
            case .question:
                
                if let questionType = QuestionType(rawValue: indexPath.row) {
                    
                    switch questionType {
                    case .text:
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTextCell.reuseId, for: indexPath) as? QuestionTextCell else { return UITableViewCell() }
                        cell.configure(questionProvider.currentQuestion)
                        return cell
                        
                    case .image:
                        
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionImageCell.reuseId, for: indexPath) as? QuestionImageCell else { return UITableViewCell() }
                        cell.configure(questionProvider.currentQuestion)
                        return cell
                    }
                }
                
            case .answer:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.reuseId, for: indexPath) as? AnswerCell else { return UITableViewCell() }
                
                let answer = questionProvider.currentQuestion?.answers[indexPath.row]
                
                cell.configure(answer)
                cell.delegate = self
                
                return cell
                
            case .button:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckButtonCell.reuseId, for: indexPath) as? CheckButtonCell else { return UITableViewCell() }
                
                cell.configure(questionProvider.currentQuestion)
                cell.delegate = self
                
                return cell
            }
        }
        return UITableViewCell()
    }
    
}
//MARK: - UITableViewDelegate
extension GameVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if let sectionType = QuestionSectionType.init(rawValue: indexPath.section) {
            switch sectionType {
            case .question:
                
                if let questionType = QuestionType(rawValue: indexPath.row) {
                    switch questionType {
                    case .text:
                        return questionProvider.currentQuestion?.text == "" ? 0 : UITableView.automaticDimension
                    case .image:
                        return questionProvider.currentQuestion?.image == "" ? 0 : UIScreen.main.bounds.width
                    }
                }
                
            default: return UITableView.automaticDimension
            }
        }
        return UITableView.automaticDimension
    }
}

//MARK: - CheckButtonCellDelegate
extension GameVC: CheckButtonCellDelegate {
    
    func checkButtonCellNextQuestion() {
        
        let (_, number, count) = questionProvider.nextQuestion()
        questionNumberHeader.configure(currentQuestion: number, numberOfQuestions: count)
        
        tableView.reloadData()
        
    }
}
//MARK: - AnswerCellDelegate
extension GameVC: AnswerCellDelegate {
    
    func answerCellSelectAnswer() {
        
        tableView.reloadData()
        
    }
}
