//
//  OpenAIHelper.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 22/02/2026.
//

import Foundation

public struct ChatMessage: Codable {
    public init(role: OpenAIMessageRole, content: String) {
        self.role = role
        self.content = content
    }
    
    let role: OpenAIMessageRole
    let content: String
}

struct ChatRequest: Codable {
    let model: String
    let messages: [ChatMessage]
    let temperature: Double?
}

struct ChatResponse: Codable {
    struct Choice: Codable {
        let message: ChatMessage
    }

    let choices: [Choice]
}

public enum OpenAIModel: String {
    case nano = "gpt-4.1-nano"
    case mini = "gpt-4.1-mini"
}

public enum OpenAIMessageRole: String, Codable {
    case system = "system"
    case user = "user"
    case assistant = "assistant"
}


final public class OpenAIHelper {
    
    private let apiKey: String
    private let model: OpenAIModel
    private let baseURL = URL(string: "https://api.openai.com/v1/chat/completions")!

    public init(apiKey: String, model: OpenAIModel) {
        self.apiKey = apiKey
        self.model = model
    }

    public func sendChat<T: Codable>(messages: [ChatMessage], model: OpenAIModel, temperature: Double? = nil) async throws -> T {

        let requestBody = ChatRequest(
            model: model.rawValue,
            messages: messages,
            temperature: temperature
        )

        var request = URLRequest(url: baseURL)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(requestBody)

        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        let decoded = try JSONDecoder().decode(ChatResponse.self, from: data)
        
        guard let content = decoded.choices.first?.message.content,
              let jsonData = content.data(using: .utf8)
        else {
            print("❌ OPENAIHELPER: BAD SERVER RESPONSE")
            throw URLError(.badServerResponse)
        }
        
        let type = try JSONDecoder().decode(T.self, from: jsonData)
        print(type)
        return type
        
    }
}
