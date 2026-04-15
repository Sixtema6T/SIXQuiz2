//
//  QuizConverterTests.swift
//  SIXQuizTests
//
//  Created by Sixtema
//

import Testing
import Foundation
@testable import SIXQuiz

@Suite("QuizConverter Tests")
struct QuizConverterTests {
    
    @Test("Convert quiz item DTO array to domain")
    @MainActor
    func convertQuizItemDTOArrayToDomain() {
        let dtos = [
            QuizItemDTO(
                id: 1,
                type: "selector|comment",
                question: "What do you think?",
                desc: "Rate your experience"
            ),
            QuizItemDTO(
                id: 2,
                type: "comment",
                question: "Any suggestions?",
                desc: "We want to know"
            )
        ]
        
        let domain = QuizConverter.convert(dtos)
        
        #expect(domain.count == 2)
        #expect(domain[0].id == 1)
        #expect(domain[0].question == "What do you think?")
        #expect(domain[0].types.count == 2)
        #expect(domain[1].id == 2)
        #expect(domain[1].types.count == 1)
    }
    
    @Test("Convert quiz domain array to UIModel pages")
    @MainActor
    func convertQuizDomainArrayToUIModelPages() {
        let domain = [
            QuizItemDomain(
                id: 1,
                types: [.selector],
                question: "Question 1",
                desc: "Description 1"
            ),
            QuizItemDomain(
                id: 2,
                types: [.comment],
                question: "Question 2",
                desc: "Description 2"
            )
        ]
        
        let uiModels = QuizConverter.convert(domain)
        
        #expect(uiModels.count == 2)
        #expect(uiModels[0][0].id == 1)
        #expect(uiModels[1][0].id == 2)
    }
    
    @Test("Convert answer domain to DTO")
    @MainActor
    func convertAnswerDomainToDTO() {
        let answer1 = QuizAnswerDomain(id: 1)
        answer1.score = 5
        answer1.comment = "Great app!"
        
        let answer2 = QuizAnswerDomain(id: 2)
        answer2.score = 0
        answer2.comment = ""
        
        let answers = [answer1, answer2]
        
        let dto = QuizConverter.convert(answers, userId: "test-user-id")
        
        #expect(dto.answers.count == 2)
        #expect(dto.answers[0].questionId == 1)
        #expect(dto.answers[0].value == 5)
        #expect(dto.answers[0].comment == "Great app!")
        #expect(dto.answers[1].value == nil)
        #expect(dto.answers[1].comment == nil)
        #expect(dto.deviceInfo.platform == "iOS")
        #expect(dto.userId == "test-user-id")
    }
}
