//
//  QuizItemUIModel.swift
//  SIXQuiz
//
//  Created by Sixtema
//

struct QuizItemUIModel: Identifiable, Codable {
    let id: Int
    let types: [QuizItemType]
    let question: String
    let desc: String
}
