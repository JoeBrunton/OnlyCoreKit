//
//  OpenAIHelper.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 22/02/2026.
//

import Foundation


/// A lightweight helper responsible for sending chat completion requests to the OpenAI API
/// and decoding structured responses.
///
/// `OpenAIHelper` provides a strongly-typed interface for interacting with the
/// `/v1/chat/completions` endpoint. It handles request construction, authentication,
/// JSON encoding/decoding, and response extraction.
///
/// The helper is designed to decode the model’s response into a caller-specified
/// `Codable` type, allowing you to request structured JSON output from the model
/// and receive it as a native Swift type.
///
/// ## Usage
///
/// ```swift
/// let helper = OpenAIHelper(apiKey: "YOUR_API_KEY", model: .gpt41nano)
/// let result: MyResponse = try await helper.sendChat(
///     messages: messages,
///     model: .gpt41nano
/// )
/// ```
///
/// - Note: The API key is sent using Bearer token authentication.
/// - Important: The model must return valid JSON that matches the expected
///   `Codable` type, otherwise decoding will fail.
/// - Warning: This class does not perform retry logic or advanced error inspection.
///   Production implementations may wish to extend error handling.
final public class OpenAIHelper {
    
    private let apiKey: String
    private let model: OpenAIModel
    private var aiBaseURL: URL = URL(string: "https://api.openai.com/v1/chat/completions")!

    public init(apiKey: String, model: OpenAIModel, aiBaseURL: URL = URL(string: "https://api.openai.com/v1/chat/completions")!) {
        self.apiKey = apiKey
        self.model = model
        self.aiBaseURL = aiBaseURL
    }
    
    /// Sends a chat completion request to the OpenAI API and decodes the response
    /// into a strongly-typed value.
    ///
    /// This method constructs a request using the provided chat messages and model,
    /// performs a `POST` request to the configured API endpoint, and attempts to
    /// decode the model’s first response message as JSON into the specified type `T`.
    ///
    /// The model is expected to return valid JSON content in its message body.
    /// That JSON is then decoded into the generic `Codable` type supplied by the caller.
    ///
    /// ## Example
    ///
    /// ```swift
    /// struct Joke: Codable {
    ///     let setup: String
    ///     let punchline: String
    /// }
    ///
    /// let joke: Joke = try await helper.sendChat(
    ///     messages: messages,
    ///     model: .gpt4,
    ///     temperature: 0.7
    /// )
    /// ```
    ///
    /// - Parameters:
    ///   - messages: The conversation history to send to the model.
    ///   - model: The OpenAI model to use for the completion.
    ///   - temperature: An optional sampling temperature. Higher values produce more
    ///     creative responses; lower values produce more deterministic output.
    ///
    /// - Returns: A decoded instance of type `T` based on the model’s JSON response.
    ///
    /// - Throws:
    ///   - `URLError(.badServerResponse)` if the response does not contain usable content.
    ///   - Any encoding or decoding errors encountered during request or response processing.
    ///
    /// - Important: The model’s response must be valid UTF-8 encoded JSON matching `T`.
    ///   If the response contains plain text or malformed JSON, decoding will fail.
    public func sendChat<T: Codable>(messages: [ChatMessage], model: OpenAIModel, temperature: Double? = nil) async throws -> T {

        let requestBody = ChatRequest(
            model: model.rawValue,
            messages: messages,
            temperature: temperature
        )

        var request = URLRequest(url: aiBaseURL)
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
