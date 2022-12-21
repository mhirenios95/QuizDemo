//
//  quizQuestion.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import Foundation

struct QuestionsModel: Codable {
    var results: [quizQuestions]?
    var responseCode: Int?
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case responseCode = "response_code"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([quizQuestions].self, forKey: .results)
        responseCode = try values.decodeIfPresent(Int.self, forKey: .responseCode)
    }
}
//MARK: quiz Questions
struct quizQuestions:Codable {
    var category: String?
    var type: String?
    var difficulty: String?
    var question: String?
    var correct_answer:String?
    var incorrect_answers:[String]?
    
    enum CodingKeys: String, CodingKey {

        case category = "category"
        case type = "type"
        case difficulty = "difficulty"
        case question = "question"
        case correct_answer = "correct_answer"
        case incorrect_answers = "incorrect_answers"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category = try values.decodeIfPresent(String.self, forKey: .category)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        difficulty = try values.decodeIfPresent(String.self, forKey: .difficulty)
        question = try values.decodeIfPresent(String.self, forKey: .question)
        correct_answer = try values.decodeIfPresent(String.self, forKey: .correct_answer)
        incorrect_answers = try values.decodeIfPresent([String].self, forKey: .incorrect_answers)
    }

}
