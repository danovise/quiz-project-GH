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
    let text, image: String?
    let answers: [Answer]
}

// MARK: - Answer
struct Answer: Codable {
    let text: String
    let isCorrect, isSelected: Bool
}
