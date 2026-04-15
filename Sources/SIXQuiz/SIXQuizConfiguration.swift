//
//  SIXQuizConfiguration.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import SwiftUI

public struct SIXQuizConfiguration: Sendable {
    
    // MARK: - Network
    let baseURL: String
    let questionsPath: String
    let answersPath: String
    let applicationName: String
    let languageCode: String
    let userId: String
    
    // MARK: - Appearance
    let accentColor: Color
    
    // MARK: - Texts
    let welcomeTitle: String
    let welcomeMessage: String
    let startButtonTitle: String
    let finishedTitle: String
    let finishedMessage: String
    let exitButtonTitle: String
    let sendButtonTitle: String
    let continueButtonTitle: String
    let commentPlaceholder: String
    let errorTitle: String
    let errorMessage: String
    let errorAcceptButton: String
    
    // MARK: - Images (nil = use default from SPM bundle)
    let welcomeImage: Image?
    let finishedImage: Image?
    let starFilledImage: Image?
    let starEmptyImage: Image?
    
    // MARK: - Callbacks
    let onAppear: (@Sendable () -> Void)?
    
    public init(
        baseURL: String,
        questionsPath: String,
        answersPath: String,
        applicationName: String,
        languageCode: String,
        userId: String,
        accentColor: Color,
        welcomeTitle: String = "Help us\nimprove your\nexperience!",
        welcomeMessage: String = "Help us improve your experience with this short survey.",
        startButtonTitle: String = "Start",
        finishedTitle: String = "Thank you very much for\nparticipating!",
        finishedMessage: String = "Your feedback is very important.",
        exitButtonTitle: String = "Exit",
        sendButtonTitle: String = "Send",
        continueButtonTitle: String = "Continue",
        commentPlaceholder: String = "What would improve your experience?",
        errorTitle: String = "Error",
        errorMessage: String = "An error occurred.",
        errorAcceptButton: String = "Accept",
        welcomeImage: Image? = nil,
        finishedImage: Image? = nil,
        starFilledImage: Image? = nil,
        starEmptyImage: Image? = nil,
        onAppear: (@Sendable () -> Void)? = nil
    ) {
        self.baseURL = baseURL
        self.questionsPath = questionsPath
        self.answersPath = answersPath
        self.applicationName = applicationName
        self.languageCode = languageCode
        self.userId = userId
        self.accentColor = accentColor
        self.welcomeTitle = welcomeTitle
        self.welcomeMessage = welcomeMessage
        self.startButtonTitle = startButtonTitle
        self.finishedTitle = finishedTitle
        self.finishedMessage = finishedMessage
        self.exitButtonTitle = exitButtonTitle
        self.sendButtonTitle = sendButtonTitle
        self.continueButtonTitle = continueButtonTitle
        self.commentPlaceholder = commentPlaceholder
        self.errorTitle = errorTitle
        self.errorMessage = errorMessage
        self.errorAcceptButton = errorAcceptButton
        self.welcomeImage = welcomeImage
        self.finishedImage = finishedImage
        self.starFilledImage = starFilledImage
        self.starEmptyImage = starEmptyImage
        self.onAppear = onAppear
    }
}
