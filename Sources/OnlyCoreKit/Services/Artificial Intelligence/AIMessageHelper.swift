//
//  AIMessageHelper.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 26/02/2026.
//

import Foundation

/// The message object to send to the AI API and the structure that contains the response to user on return.
///
///
/// - Parameters:
///
///     - role: ``OpenAIMessageRole`` defines the 'actor' of the message.
///     - content: represents the passed message to send or receive from the AI API
///
/// ## Usage
/// ```swift
///ChatMessage(role: .user, content: "Is the meaning of life really 42?")
/// ```
///
public struct ChatMessage: Codable {
    let role: OpenAIMessageRole
    let content: String
}

/// The structure of the request to be sent to the AI API
///
/// - Parameters:
///
///     - model: String representing the raw value from the enum ``OpenAIModel``.
///     - messages: an array of ``ChatMessage`` objects representing the cache of the chat.
///     - temperature: An optional sampling temperature. Higher values produce more creative responses; lower values produce more deterministic output.
///
///
/// ## Usage
/// ``` swift
/// let requestBody = ChatRequest(
/// model: model.rawValue,
/// messages: messages,
/// temperature: temperature
/// )
///
/// var request = URLRequest(url: aiBaseURL)
///
/// request.httpBody = try JSONEncoder().encode(requestBody)
/// ```
///
struct ChatRequest: Codable {
    let model: String
    let messages: [ChatMessage]
    let temperature: Double?
}

/// The response structure from the API call
///
/// - Note:
/// Because the API can return multiple response to the same call to allow the user to choose between, and because the ``Choice`` parameters could change, ``ChatResponse`` is separate from ``ChatMessage``
///
/// - Parameters:
///     - choices: returns an array of ``Choice`` objects stored as an internal Struct
///
/// ## Usage
/// ```swift
/// let decoded = try JSONDecoder().decode(ChatResponse.self, from: data)
///
/// guard let content = decoded.choices.first?.message.content,
///       let jsonData = content.data(using: .utf8)
/// else {
///     throw URLError(.badServerResponse)
/// }
/// ```
///
struct ChatResponse: Codable {
    struct Choice: Codable {
        let message: ChatMessage
    }

    let choices: [Choice]
}

/// Centralised AI model string reference enum
///
/// - Parameters:
///     - nano: GPT-4.1 nano excels at instruction following and tool calling. It features a 1M token context window, and low latency without a reasoning step.
///     - mini: GPT-4.1 mini excels at instruction following and tool calling. It features a 1M token context window, and low latency without a reasoning step.
///     - fiveMini: GPT-5 mini is a faster, more cost-efficient version of GPT-5. It's great for well-defined tasks and precise prompts.
public enum OpenAIModel: String {
    case gpt41nano = "gpt-4.1-nano"
    case gpt41mini = "gpt-4.1-mini"
    case gpt5mini = "gpt-5-mini"
}

/// Centralised AI role string reference enum
///
/// - Parameters:
///     - system: sets the behaviour of the AI as well as the context
///     - user: input from the user
///     - assistant: output from the AI
public enum OpenAIMessageRole: String, Codable {
    case system = "system"
    case user = "user"
    case assistant = "assistant"
}
