//
//  CategoryModel.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import Foundation
struct CategoryModel: Codable {
    var triviaCategory: [TriviaCategory]?
    enum CodingKeys: String, CodingKey {
        case triviaCategory = "trivia_categories"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        triviaCategory = try values.decodeIfPresent([TriviaCategory].self, forKey: .triviaCategory)
    }
}
struct TriviaCategory: Codable {
    var strID: Int?
    var name: String?
    enum CodingKeys: String, CodingKey {
        case strID = "id"
        case name = "name"
    }
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        strID = try values.decodeIfPresent(Int.self, forKey: .strID)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
