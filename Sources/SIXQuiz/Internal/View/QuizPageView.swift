//
//  QuizPageView.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import SwiftUI
import SIXFonts

struct QuizPageView: View {
    
    @EnvironmentObject private var viewModel: QuizViewModel
    let configuration: SIXQuizConfiguration
    let questions: [QuizItemUIModel]
    let answers: [QuizAnswerDomain]
    let isLast: Bool
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                ForEach(questions) { question in
                    let answer: QuizAnswerDomain? = answers.first {
                        question.id == $0.id
                    }
                    if let answer = answer {
                        QuizQuestionView(configuration: configuration, question: question, answer: answer, isLast: isLast)
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 100)
            }
            .padding(.horizontal)
            .background(Color(.systemBackground))

            HStack {
                Button {
                    if isLast {
                        Task {
                            await viewModel.sendAnswers()
                        }
                    } else {
                        withAnimation {
                            if viewModel.pageSelected < viewModel.questions.indices.last ?? 0 {
                                viewModel.pageSelected += 1
                            }
                        }
                    }
                } label: {
                    Text(.init(isLast ? configuration.sendButtonTitle : configuration.continueButtonTitle))
                }
                .frame(height: 40)
                .foregroundStyle(.white)
                .padding(.horizontal, 16)
                .background(configuration.accentColor)
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .frame(maxWidth: .infinity)
            .frame(height: 70, alignment: .top)
            .padding(.vertical)
            .background(Color(.systemBackground))
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}
