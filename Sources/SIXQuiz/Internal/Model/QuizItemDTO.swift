//
//  QuizItemDTO.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation

struct QuizItemDTO: Codable, Identifiable {
    let id: Int
    let type: String
    let question: String
    let desc: String
    
    enum CodingKeys: String, CodingKey {
        case id, type, question
        case desc = "description"
    }
}
