//
//  QuizViewModelTests.swift
//  SIXQuizTests
//
//  Created by Sixtema
//

import Testing
import Foundation
import SwiftUI
@testable import SIXQuiz

@Suite("QuizViewModel Tests")
struct QuizViewModelTests {
    
    private func makeConfiguration() -> SIXQuizConfiguration {
        SIXQuizConfiguration(
            baseURL: "https://example.com",
            questionsPath: "/preguntas",
            answersPath: "/respuestas",
            applicationName: "test_app",
            languageCode: "gl",
            userId: "test-user-id",
            accentColor: .blue
        )
    }
    
    @Test("ViewModel initial state")
    @MainActor
    func viewModelInitialState() {
        let viewModel = QuizViewModel(configuration: makeConfiguration())
        
        #expect(viewModel.questions.isEmpty)
        #expect(viewModel.isFinished == false)
        #expect(viewModel.loader == false)
        #expect(viewModel.error == false)
    }
    
    @Test("ViewModel page selection")
    @MainActor
    func viewModelPageSelection() {
        let viewModel = QuizViewModel(configuration: makeConfiguration())
        
        viewModel.pageSelected = 1
        #expect(viewModel.pageSelected == 1)
        
        viewModel.pageSelected = 2
        #expect(viewModel.pageSelected == 2)
    }
    
    @Test("ViewModel user answers initially empty")
    @MainActor
    func viewModelUserAnswersInitiallyEmpty() {
        let viewModel = QuizViewModel(configuration: makeConfiguration())
        #expect(viewModel.userAnswers.isEmpty)
    }
}
