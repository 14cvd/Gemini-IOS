//
//  APIKey.swift
//  My AI
//
//  Created by cavID on 25.04.24.
//

import Foundation



enum APIKey {

    static var `default`: String {
        guard let filePath = Bundle.main.path(forResource: "Key", ofType: "plist")
        else {
            print("Key Problem")

            fatalError("Couldn't find file 'GenerativeAI-Info.plist'.")
        }
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let value = plist?.object(forKey: "API_KEY") as? String else {
            fatalError("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist'.")
            print("Key Problem2")

        }
        if value.starts(with: "_") || value.isEmpty {
            fatalError(
                "Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key."
            )
            print("Key Problem3")

        }
        return value
    }
}
