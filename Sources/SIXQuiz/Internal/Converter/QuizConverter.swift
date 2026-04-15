//
//  QuizConverter.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation
import UIKit

@MainActor
struct QuizConverter {
    
    static func convert(_ dto: [QuizItemDTO]) -> [QuizItemDomain] {
        return dto.map { dto in
            let types: [QuizItemType] = dto.type
                .split(separator: "|")
                .compactMap {
                    QuizItemType(rawValue: String($0))
                }
            
            return QuizItemDomain(
                id: dto.id,
                types: types,
                question: dto.question,
                desc: dto.desc
            )
        }
    }
    
    static func convert(_ domain: [QuizItemDomain]) -> [[QuizItemUIModel]] {
        let mapped: [QuizItemUIModel] = domain.map { domain in
            return QuizItemUIModel(
                id: domain.id,
                types: domain.types,
                question: domain.question,
                desc: domain.desc)
        }
        
        let splitted: [[QuizItemUIModel]] = mapped.chunked(into: 1)
        return splitted
    }
    
    static func convert(_ domain: [QuizAnswerDomain], userId: String) -> QuizAnswerDTO {
        let dtoAnswers = domain.map { answer in
            let questionId: Int = answer.id
            let value: Int? = answer.score == 0 ? nil : answer.score
            let comment: String? = answer.comment.isEmpty ? nil : answer.comment
            
            return QuizAnswerDTO.Answer(
                questionId: questionId,
                value: value,
                comment: comment
            )
        }
        
        let platform: String = "iOS"
        let osVersion: String = UIDevice.current.systemVersion
        let appVersion: String = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?"
        
        let deviceInfo = QuizAnswerDTO.DeviceInfo(
            platform: platform,
            osVersion: osVersion,
            appVersion: appVersion
        )
        
        return QuizAnswerDTO(
            userId: userId,
            answers: dtoAnswers,
            deviceInfo: deviceInfo
        )
    }
}
