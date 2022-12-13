//
//  QuestionsResponse.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import Foundation

// MARK: - QuestionsResponse
struct QuestionsResponse: Codable {
    let items: [Question]
}

// MARK: - Item
struct Question: Codable {
    let id: Int
    let text, image: String?
    let type: String
    let category: String
    let answers: [Answer]
}

// MARK: - Answer
class Answer: Codable {
    let id: Int
    let text: String
    let isCorrect: Bool
    
    var isSelected: Bool
}
