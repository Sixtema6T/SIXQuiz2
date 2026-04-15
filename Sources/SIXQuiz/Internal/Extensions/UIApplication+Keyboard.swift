//
//  UIApplication+Keyboard.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import SwiftUI

extension UIApplication {
    func dismissQuizKeyboard() {
        Task { @MainActor in
            sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
