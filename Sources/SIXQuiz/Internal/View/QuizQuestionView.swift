//
//  QuizQuestionView.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import SwiftUI
import SIXFonts

struct QuizQuestionView: View {
    
    let configuration: SIXQuizConfiguration
    let question: QuizItemUIModel
    @ObservedObject var answer: QuizAnswerDomain
    let isLast: Bool
    @State private var emptytext: String = ""
    @FocusState private var textFieldFocused: Bool?
    
    private var starFilled: Image {
        configuration.starFilledImage ?? Image("quiz_star_filled", bundle: .module)
    }
    
    private var starEmpty: Image {
        configuration.starEmptyImage ?? Image("quiz_star_not_filled", bundle: .module)
    }
    
    var body: some View {
        VStack(spacing: 24) {
            
            Text(.init(question.question.uppercased()))
                .foregroundStyle(configuration.accentColor)
                .font(.bold(17))

            if !question.desc.isEmpty {
                Text("\(question.desc)")
                    .font(.bold(15))
            }
            
            if question.types.contains(.selector) {
                HStack(spacing: 16) {
                    ForEach(1...5, id: \.self) { index in
                        Button {
                            withAnimation {
                                if answer.score == 1 && index == 1 {
                                    answer.score = 0
                                } else {
                                    answer.score = index
                                }
                            }
                        } label: {
                            (answer.score >= index ? starFilled : starEmpty)
                                .frame(width: 42, height: 42)
                        }
                        .foregroundStyle(.black)
                    }
                }
                .padding(.top, 20)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            if question.types.contains(.comment) {
                VStack {
                    TextEditor(text: $answer.comment)
                        .frame(maxWidth: .infinity)
                        .frame(height: 160)
                        .scrollContentBackground(.hidden)
                        .multilineTextAlignment(.leading)
                        .font(.regular(17))
                        .cornerRadius(8)
                        .zIndex(1)
                        .focused($textFieldFocused, equals: true)
                        .overlay {
                            TextField(.init(configuration.commentPlaceholder), text: $emptytext)
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .scrollContentBackground(.hidden)
                                .multilineTextAlignment(.leading)
                                .foregroundStyle(.gray)
                                .font(.regular(17))
                                .disabled(true)
                                .opacity(textFieldFocused == true ? 0.0 : answer.comment.isEmpty ? 1.0 : 0.0)
                                .padding(.leading, 8)
                                .padding(.top, 8)
                        }
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(textFieldFocused == true ? configuration.accentColor : answer.comment.isEmpty ? Color.gray.opacity(0.4) : configuration.accentColor, lineWidth: 1)
                        }
                        .onChange(of: answer.comment) { newValue in
                            if newValue.count > 100 {
                                answer.comment = String(newValue.prefix(100))
                            }
                        }
                    Text("\(answer.comment.count)/100")
                        .font(.system(size: 10))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.top)
            }
        }
        .padding(24)
        .padding(.top, 20)
        .multilineTextAlignment(.center)
    }
}
