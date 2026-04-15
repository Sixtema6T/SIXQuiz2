//
//  QuizLoaderService.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation

struct QuizLoaderService: Sendable {
    
    let repository: QuizRepository
    
    init(configuration: SIXQuizConfiguration) {
        self.repository = QuizRepository(configuration: configuration)
    }
    
    func loadQuizItems() async throws -> [QuizItemDomain] {
        try await repository.loadQuizItems()
    }
    
    func sendQuizItems(dto: QuizAnswerDTO) async throws {
        try await repository.sendQuizAnswers(dto)
    }
}
