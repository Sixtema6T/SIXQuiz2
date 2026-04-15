//
//  QuizAnswerDomain.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import SwiftUI

final class QuizAnswerDomain: ObservableObject, Identifiable {
    let id: Int
    @Published var score: Int = 0
    @Published var comment: String = ""
    
    init(id: Int) {
        self.id = id
    }
}
