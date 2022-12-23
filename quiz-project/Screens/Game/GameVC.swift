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
    
    var provider: QuestionsProvider
    
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
        self.provider = questionProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        setupViews()
        setupConstraints()
        
        fetchQuestions()
    }
    
    //MARK: - Request
    private func fetchQuestions() {
        
        let (_, number, count) = self.provider.nextQuestion()
        questionNumberHeader.configure(currentQuestion: number, numberOfQuestions: count)
        tableView.reloadData()
    }
    
    //MARK: - Private
private func setupViews() {
    navigationController?.isNavigationBarHidden = true
    view.addSubview(tableView)
}

private func setupConstraints() {
    tableView.snp.makeConstraints { make in
        make.edges.equalToSuperview()
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
            case .answer: return provider.currentQuestion?.answers.count ?? 0
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
                        cell.configure(provider.currentQuestion)
                        return cell
                        
                    case .image:
                        
                        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuestionImageCell.reuseId, for: indexPath) as? QuestionImageCell else { return UITableViewCell() }
                        
                        cell.configure(provider.currentQuestion)
                        return cell
                    }
                }
                
            case .answer:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.reuseId, for: indexPath) as? AnswerCell else { return UITableViewCell() }
                let answer = provider.currentQuestion?.answers[indexPath.row]
                
                cell.configure(answer, buttonState: provider.checkButtonState, answerIsCorrect: provider.answerIsCorrect, canTapAnswer: provider.canTapAnswer)
                cell.delegate = self
                
                return cell
                
            case .button:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CheckButtonCell.reuseId, for: indexPath) as? CheckButtonCell else { return UITableViewCell() }
                
                cell.configure(provider.currentQuestion, answerIsChecked: provider.answerIsChecked)
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
                        return provider.currentQuestion?.text == "" ? 0 : UITableView.automaticDimension
                    case .image:
                        return provider.currentQuestion?.image == "" ? 0 : UIScreen.main.bounds.width
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
    
    func countCorrectQuestion() {
        var isCorrect = true
        let answers = provider.currentQuestion?.answers ?? []

        for answer in answers {
            if answer.isCorrect != answer.isSelected {
                isCorrect = false

                if let correctId = provider.currentQuestion?.id {
  
                    var ids = provider.correctQuestionIds
     
                    let uncorrectId = provider.currentQuestion?.id ?? 0
                    if let indexToRemove = ids.firstIndex(where: { $0 == uncorrectId }) {
                        ids.remove(at: indexToRemove)
                    }
    
                    provider.correctQuestionIds = ids
                }
            }
        }
        
        if isCorrect == true {
            provider.numberOfCorrectQuestions += 1
            
            if let correctId = provider.currentQuestion?.id {
                
                var ids = provider.correctQuestionIds
               
                let correctId = provider.currentQuestion?.id ?? 0
     
                ids.append(correctId)
       
                provider.correctQuestionIds = Array(Set(ids))
            }
        }
    }
    
    func checkButtonCellNextQuestion(_ buttonState: CheckButtonState) {
        
        provider.checkButtonState = buttonState
        
        switch buttonState {
            
        case .check:

            countCorrectQuestion()
            tableView.reloadData()
                      
        case .next:

            let (question, number, count) = provider.nextQuestion()
            questionNumberHeader.configure(currentQuestion: number, numberOfQuestions: count)

            if question == nil {
                
                showPersonalScoreScreen()
            }
        }
        tableView.reloadData()
    }
}
//MARK: - AnswerCellDelegate
extension GameVC: AnswerCellDelegate {
    
    func answerCellSelectAnswer() {
        tableView.reloadData()
        
    }
}
//MARK: - Navigation
extension GameVC {
    
    func showPersonalScoreScreen() {
        
        let category = provider.questions.first?.category ?? ""
        
        let progress: Float = Float(provider.numberOfCorrectQuestions) / Float(provider.questions.count)
        
        let correctAnswers: Float = Float(provider.numberOfCorrectQuestions)
        
        let allQuestions: Float = Float(provider.questions.count)
        
        let percent: String = "\(Int(progress * 100))%"
        
        
        let scoreModel = Score.init(category: category, progress: progress, correctAnswers: correctAnswers, allQuestion: allQuestions, percent: percent, correctQuestionIds: provider.correctQuestionIds)
        
        let personalScoreVC = PersonalScoreVC.init(model: scoreModel)
        navigationController?.pushViewController(personalScoreVC, animated: true)
    }
    func showGlobalScoreScreen() {
        print(#function)
    }
}
