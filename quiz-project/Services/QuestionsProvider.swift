//
//  QuestionsProvider.swift
//  quiz-project
//
//  Created by Daria Sechko on 23.10.22.
//

import Foundation
import FirebaseDatabase

protocol QuestionsProvider {
    
    var allQuestions: [Question] { get set } //все вопросы - 10
    var questions: [Question] { get set } //текущий список вопросов
    var currentQuestion: Question? { get set }
    var correctQuestionIds: Array<Int> { get set }
    var checkButtonState: CheckButtonState { get set }
    
    var answerIsChecked: (Bool, Int) { get }
    var answerIsCorrect: Bool { get } //вопрос отвечен правильно
    var canTapAnswer: Bool { get }
    
    var numberOfCorrectQuestions: Int { get set }
  
    func fetchAllLocalQuestions()
    func fetchAllQuestions(completion: @escaping ()->())
    func nextQuestion() -> (Question?, Int, Int)
    func shuffleQuestions() //Рандом - перемешать вопросы
}

class QuestionsProviderImpl: QuestionsProvider {
    
    var allQuestions: [Question] = []
    var questions: [Question] = []
    var currentQuestion: Question? = nil
    var checkButtonState: CheckButtonState = .next
    var numberOfCorrectQuestions = 0 //счетчик правильных ответов
    
    var correctQuestionIds: [Int] {
        get {
            let array = UserDefaults.standard.array(forKey: "correctQuestionIds") as? [Int] ?? []
            return array
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "correctQuestionIds")
        }
    }
   
    var canTapAnswer: Bool {
        let (_, selectedCount) = answerIsChecked // количество выбранных
        let type = currentQuestion?.type ?? "" //тип вопроса
        if selectedCount >= 1, type.contains("single") || type.contains("binary") {
            return false
        }
        return true
    }
    
    var answerIsCorrect: Bool {
        let answers = currentQuestion?.answers ?? []
        for answer in answers {
            if answer.isCorrect != answer.isSelected {
                return false
            }
        }
        return true
    }
    
    var answerIsChecked: (Bool, Int) {
        var selectedCount = 0
        var isSelected = false
        let answers = currentQuestion?.answers ?? []
        for answer in answers {
            if answer.isSelected == true {
                isSelected = true
                selectedCount += 1
            }
        }
        return (isSelected, selectedCount)
    }
    
    var jsonService: JsonService
    
    init(jsonService: JsonService) {
        self.jsonService = jsonService
    }
    
    func fetchAllLocalQuestions() {
        if let questions = jsonService.loadJson(filename: "questions") {
            allQuestions = questions //список всех вопросов
            self.questions = questions //список активных вопросов
        }
    }
    
    func fetchAllQuestions(completion: @escaping ()->()) {

        let ref = Database.database().reference()

        ref.child("items").observe(.value) { snapshot in

            guard let children = snapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            
         //   print(snapshot)
            
            let objects: [Question] = children.compactMap { snapshot in

                return try? JSONDecoder().decode(Question.self, from: snapshot.data!)

            }

            self.allQuestions = objects //список всех вопросов
            self.questions = objects //список активных вопросов

            completion()
        }
    }
    
    func nextQuestion() -> (Question?, Int, Int) { //question, number, count
        currentQuestion = questions.first
        self.questions = Array(questions.dropFirst())
        
        return (currentQuestion, allQuestions.count - questions.count, allQuestions.count)
    }
    
    func shuffleQuestions() {
        allQuestions.shuffle()
    }
}
//MARK: - DataSnapshot
extension DataSnapshot {
    var data: Data? {
        guard let value = value, !(value is NSNull) else { return nil }
        return try? JSONSerialization.data(withJSONObject: value)
    }
    var json: String? { data?.string }
}
extension Data {
    var string: String? { String(data: self, encoding: .utf8) }
}
