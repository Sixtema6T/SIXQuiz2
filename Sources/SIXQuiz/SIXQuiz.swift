//
//  SIXQuiz.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import SwiftUI
import SIXFonts

public struct SIXQuiz: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel: QuizViewModel
    @State private var intro = true
    
    private let configuration: SIXQuizConfiguration
    
    public init(configuration: SIXQuizConfiguration) {
        self.configuration = configuration
        self._viewModel = StateObject(wrappedValue: QuizViewModel(configuration: configuration))
    }
    
    private var welcomeImage: Image {
        configuration.welcomeImage ?? Image("quiz_1", bundle: .module)
    }
    
    private var finishedImage: Image {
        configuration.finishedImage ?? Image("quiz_2", bundle: .module)
    }
    
    public var body: some View {
        VStack {
            ZStack {
                TabView(selection: $viewModel.pageSelected) {
                    ForEach(viewModel.questions.indices, id: \.self) { groupIndex in
                        QuizPageView(
                            configuration: configuration,
                            questions: viewModel.questions[groupIndex],
                            answers: viewModel.userAnswers,
                            isLast: groupIndex == viewModel.questions.indices.last
                        )
                        .environmentObject(viewModel)
                        .tag(groupIndex)
                    }
                }
                .padding(.vertical)
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                welcome
                finished
                
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 35, height: 35)
                        .clipShape(Circle())
                }
                .padding()
                .contentShape(Rectangle())
                .foregroundStyle(Color(.label))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                
                // Custom pager dots
                HStack {
                    ForEach(viewModel.questions.indices, id: \.self) { index in
                        Circle()
                            .fill(index == viewModel.pageSelected ? configuration.accentColor : .gray.opacity(0.5))
                            .frame(width: 7, height: 7)
                    }
                }
                .padding(.bottom, 40)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .opacity((intro == true || viewModel.isFinished == true) ? 0.0 : 1.0)
                
                if viewModel.loader {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.gray.opacity(0.6))
                        .ignoresSafeArea()
                }
            }
        }
        .background(Color(.systemBackground))
        .alert(.init(configuration.errorTitle), isPresented: $viewModel.error, actions: {
            Button {
                dismiss()
            } label: {
                Text(.init(configuration.errorAcceptButton))
            }
        }, message: {
            Text(.init(configuration.errorMessage))
        })
        .task {
            await viewModel.getQuestions()
        }
        .onAppear {
            configuration.onAppear?()
        }
    }
    
    private var welcome: some View {
        VStack(spacing: 16) {
            
            welcomeImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            Text(.init(configuration.welcomeTitle))
                .font(.bold(22))
                .multilineTextAlignment(.center)
            
            Text(.init(configuration.welcomeMessage))
                .multilineTextAlignment(.center)
                .font(.regular(17))
                .padding(.horizontal)

            Spacer()
            
            Button {
                withAnimation {
                    intro = false
                }
            } label: {
                Text(.init(configuration.startButtonTitle))
            }
            .frame(height: 40)
            .foregroundStyle(.white)
            .padding(.horizontal, 16)
            .background(configuration.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .offset(y: -37)
        }
        .padding(44)
        .padding(.top, 24)
        .background(Color(.systemBackground))
        .opacity(intro ? 1.0 : 0.0)
    }
    
    private var finished: some View {
        VStack(spacing: 16) {
            
            finishedImage
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 250)
            
            Text(.init(configuration.finishedTitle))
                .font(.bold(22))
                .multilineTextAlignment(.center)
            
            Text(.init(configuration.finishedMessage))
                .multilineTextAlignment(.center)
                .font(.regular(17))
                .padding(.horizontal)
            
            Spacer()
            
            Button {
                withAnimation {
                    dismiss()
                }
            } label: {
                Text(.init(configuration.exitButtonTitle))
            }
            .frame(height: 40)
            .foregroundStyle(.white)
            .padding(.horizontal, 24)
            .background(configuration.accentColor)
            .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            .offset(y: -37)
        }
        .padding(44)
        .padding(.top, 24)
        .background(Color(.systemBackground))
        .opacity(viewModel.isFinished ? 1.0 : 0.0)
    }
}
