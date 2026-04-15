//
//  SIXQuizAPIClient.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation

enum SIXQuizAPIClientError: Error {
    case invalidURL
    case networkError
    case decodeError
    case httpError(code: Int)
}

struct SIXQuizAPIClient: Sendable {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Codable & Sendable>(_ endpoint: SIXQuizEndpoint) async throws -> T {
        guard let request = endpoint.urlRequest else { throw SIXQuizAPIClientError.invalidURL }
        let result: (data: Data, response: URLResponse)
        do {
            result = try await session.data(for: request)
        } catch {
            try Task.checkCancellation()
            throw SIXQuizAPIClientError.networkError
        }
        guard let httpResponse = result.response as? HTTPURLResponse else {
            throw SIXQuizAPIClientError.networkError
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw SIXQuizAPIClientError.httpError(code: httpResponse.statusCode)
        }
        do {
            return try JSONDecoder().decode(T.self, from: result.data)
        } catch {
            throw SIXQuizAPIClientError.decodeError
        }
    }
    
    func requestVoid(_ endpoint: SIXQuizEndpoint) async throws {
        guard let request = endpoint.urlRequest else { throw SIXQuizAPIClientError.invalidURL }
        let result: (data: Data, response: URLResponse)
        do {
            result = try await session.data(for: request)
        } catch {
            try Task.checkCancellation()
            throw SIXQuizAPIClientError.networkError
        }
        guard let httpResponse = result.response as? HTTPURLResponse else {
            throw SIXQuizAPIClientError.networkError
        }
        guard (200..<300).contains(httpResponse.statusCode) else {
            throw SIXQuizAPIClientError.httpError(code: httpResponse.statusCode)
        }
    }
}
