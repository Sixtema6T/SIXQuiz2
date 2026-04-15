//
//  QuizViewModel.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import SwiftUI

@MainActor
final class QuizViewModel: ObservableObject {
    
    let configuration: SIXQuizConfiguration
    let service: QuizLoaderService
    @Published var loader = false
    @Published var questions: [[QuizItemUIModel]] = []
    @Published var isFinished = false
    @Published var userAnswers: [QuizAnswerDomain] = []
    @Published var pageSelected = 0
    @Published var error = false
    
    init(configuration: SIXQuizConfiguration) {
        self.configuration = configuration
        self.service = QuizLoaderService(configuration: configuration)
    }
    
    func getQuestions() async {
        loader = true
        error = false
        defer { loader = false }
        do {
            let items: [QuizItemDomain] = try await service.loadQuizItems()
            questions = QuizConverter.convert(items)
            prepareAnswers()
        } catch is CancellationError {
            return
        } catch {
            self.error = true
        }
    }
    
    func sendAnswers() async {
        UIApplication.shared.dismissQuizKeyboard()
        loader = true
        error = false
        defer { loader = false }
        do {
            let dto: QuizAnswerDTO = QuizConverter.convert(userAnswers, userId: configuration.userId)
            try await service.sendQuizItems(dto: dto)
            withAnimation {
                isFinished = true
            }
        } catch is CancellationError {
            return
        } catch {
            self.error = true
        }
    }
    
    private func prepareAnswers() {
        userAnswers = questions.flatMap { $0 }
            .map { question in
                QuizAnswerDomain(id: question.id)
            }
    }
}
