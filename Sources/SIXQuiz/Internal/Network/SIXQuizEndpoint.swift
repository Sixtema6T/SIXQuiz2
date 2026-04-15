//
//  SIXQuizEndpoint.swift
//  SIXQuiz
//
//  Created by Sixtema
//

import Foundation

struct SIXQuizEndpoint: Sendable {
    
    let method: HTTPMethod
    let path: String
    let baseURL: String
    let headers: [String: String]
    let urlParams: [String: String]
    let body: (Encodable & Sendable)?
    
    init(
        method: HTTPMethod,
        path: String,
        baseURL: String,
        headers: [String: String] = [:],
        urlParams: [String: String] = [:],
        body: (any Encodable & Sendable)? = nil
    ) {
        self.method = method
        self.path = path
        self.baseURL = baseURL
        self.headers = headers
        self.urlParams = urlParams
        self.body = body
    }
    
    var urlRequest: URLRequest? {
        var components = URLComponents(string: baseURL + path)
        if !urlParams.isEmpty {
            components?.queryItems = urlParams.map { key, value in
                URLQueryItem(name: key, value: value)
            }
        }
        
        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        if let body, let httpBody = try? JSONEncoder().encode(body) {
            request.httpBody = httpBody
        }
        
        return request
    }
}
