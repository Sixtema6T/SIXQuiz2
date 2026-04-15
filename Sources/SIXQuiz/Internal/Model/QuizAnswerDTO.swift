//
//  QuizAnswerDTO.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation

struct QuizAnswerDTO: Codable {
    let userId: String
    let answers: [Answer]
    let deviceInfo: DeviceInfo
    
    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case answers
        case deviceInfo = "device_info"
    }
    
    struct Answer: Codable {
        let questionId: Int
        let value: Int?
        let comment: String?
        
        enum CodingKeys: String, CodingKey {
            case questionId = "question_id"
            case value
            case comment
        }
    }
    
    struct DeviceInfo: Codable {
        let platform: String
        let osVersion: String
        let appVersion: String
        
        enum CodingKeys: String, CodingKey {
            case platform
            case osVersion = "os_version"
            case appVersion = "app_version"
        }
    }
}
