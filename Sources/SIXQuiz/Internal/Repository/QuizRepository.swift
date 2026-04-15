//
//  QuizRepository.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation

struct QuizRepository: Sendable {
    
    private let apiClient: SIXQuizAPIClient
    private let configuration: SIXQuizConfiguration
    
    init(apiClient: SIXQuizAPIClient = SIXQuizAPIClient(), configuration: SIXQuizConfiguration) {
        self.apiClient = apiClient
        self.configuration = configuration
    }
    
    func loadQuizItems() async throws -> [QuizItemDomain] {
        let endpoint = SIXQuizEndpoint(
            method: .get,
            path: configuration.questionsPath,
            baseURL: configuration.baseURL,
            headers: [
                "Content-Type": "application/json",
                "Accept": "application/json, text/plain, */*"
            ],
            urlParams: [
                "aplicacion": configuration.applicationName,
                "lang": configuration.languageCode
            ])
        
        let response: [QuizItemDTO] = try await apiClient.request(endpoint)
        return await QuizConverter.convert(response)
    }
    
    func sendQuizAnswers(_ answers: QuizAnswerDTO) async throws {
        let endpoint = SIXQuizEndpoint(
            method: .post,
            path: configuration.answersPath,
            baseURL: configuration.baseURL,
            headers: [
                "Content-Type": "application/json",
                "Accept": "application/json, text/plain, */*"
            ],
            urlParams: [
                "aplicacion": configuration.applicationName,
                "lang": configuration.languageCode
            ],
            body: answers)
        
        try await apiClient.requestVoid(endpoint)
    }
}
