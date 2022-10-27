//
//  QuestionsProvider.swift
//  quiz-project
//
//  Created by Daria Sechko on 23.10.22.
//

import Foundation

protocol QuestionsProvider {
    
    var allQuestions: [Question] { get set } //все вопросы - 10
    var questions: [Question] { get set } //текущий список вопросов
    var currentQuestion: Question? { get set }
    
    var checkButtonState: CheckButtonState { get set }
    var answerIsChecked: Bool { get set }
    var numberOfCorrectQuestions: Int { get set }
    
    func fetchAllQuestions()
    func nextQuestion() -> (Question?, Int, Int)
    
    func shuffleQuestions() //Рандом - перемешать вопросы
}

class QuestionsProviderImpl: QuestionsProvider {
    
    var allQuestions: [Question] = []
    var questions: [Question] = []
    var currentQuestion: Question? = nil
    
    var checkButtonState: CheckButtonState = .next
    
    var answerIsChecked: Bool = false //ответ выбран
    var numberOfCorrectQuestions = 0 //счетчик правильных ответов
    
    var jsonService: JsonService
    
    init(jsonService: JsonService) {
        self.jsonService = jsonService
    }
    
    func fetchAllQuestions() {
        
        if let questions = jsonService.loadJson(filename: "questions") {
            allQuestions = questions //список всех вопросов
            self.questions = questions //список активных вопросов
        }
    }
    
    func nextQuestion() -> (Question?, Int, Int) { //question, number, count
        
        currentQuestion = questions.first
        self.questions = Array(questions.dropFirst())
        
        return (currentQuestion, allQuestions.count - questions.count, allQuestions.count)
    }
    
    func shuffleQuestions() {
        
    }
}
