//
//  ChatService.swift
//  My AI
//
//  Created by cavID on 25.04.24.
//
import Foundation
import GoogleGenerativeAI
import Combine

enum ChatRole {
    case user
    case model
}

struct ChatMessage: Identifiable, Equatable {
    let id = UUID().uuidString
    var role: ChatRole
    var message: String
}


class ChatService {

    private var chat: Chat?
    @Published private(set) var messages = [ChatMessage]()
    private(set) var loadingResponse = false
    
    func sendMessage(_ message: String) {
        loadingResponse = true
        
        if (chat == nil) {
            let history: [ModelContent] = messages.map { ModelContent(role: $0.role == .user ? "user" : "model", parts: $0.message)}
            chat = GenerativeModel(name: "gemini-pro", apiKey: APIKey.default).startChat(history: history)
//            print("chat : \(chat)")

        }
        if let chat {
            // MARK: Add user's message to the list
            messages.append(.init(role: .user, message: message))
            
            print(messages)
            

            Task {
                do {
                    let response = try await chat.sendMessage(message)
                    print("response : \(response)")
                    print(loadingResponse)
                    
                    loadingResponse = false
                    
                    print("123 \(loadingResponse)")

                    guard let text = response.text else {
                        messages.append(.init(role: .model, message: "Something went wrong, please try again."))
                        return
                    }
//                    print("------------------------------------------------------")
                    messages.append(.init(role: .model, message: text))
//                    print(message)
//                    print("------------------------------------------------------")
                }
                catch {
                    loadingResponse = false
                    messages.append(.init(role: .model, message: "Something went wrong, please try again."))
                }
            }

        }
        
//        // MARK: Add user's message to the list
//        messages.append(.init(role: .user, message: message))
//        print(messages)
//        
//
//        Task {
//            do {
//                let response = try await chat?.sendMessage(message)
//                print("response : \(response)")
//                
//                loadingResponse = false
//                
//                guard let text = response?.text else {
//                    messages.append(.init(role: .model, message: "Something went wrong, please try again."))
//                    return
//                }
//                
//                messages.append(.init(role: .model, message: text))
//                print("------------------------------------------------------")
//                
//                print("------------------------------------------------------")
//            }
//            catch {
//                loadingResponse = false
//                messages.append(.init(role: .model, message: "Something went wrong, please try again."))
//            }
//        }
    }
}

