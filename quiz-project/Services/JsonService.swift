//
//  JsonService.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import Foundation

protocol JsonService {
    func loadJson(filename fileName: String) -> [Question]?
}

class JsonServiceImpl: JsonService {
    
    func loadJson(filename fileName: String) -> [Question]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonResponse = try decoder.decode(QuestionsResponse.self, from: data)
                return jsonResponse.items
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
}
