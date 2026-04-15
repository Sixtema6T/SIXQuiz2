//
//  QuizItemDomain.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation

struct QuizItemDomain: Identifiable, Codable {
    let id: Int
    let types: [QuizItemType]
    let question: String
    let desc: String
}
