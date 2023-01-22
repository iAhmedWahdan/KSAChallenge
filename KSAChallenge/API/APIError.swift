//
//  APIError.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 22/01/2023.
//

import Foundation

public enum APIError: LocalizedError {
    public init(_ error: Error) {
        self = .localizedDescription(error.localizedDescription)
    }
    
    public init(_ string: String) {
        self = .localizedDescription(string)
    }
    
    case message(String?)
    case badStatusCode(statusCode: Int)
    case jsonDecodingFailed

    case localizedDescription(String)
    
    case badURL
    
    case jwtError
    
    case somethingWentWrong
    
    public var errorDescription: String? {
        switch self {
        case .localizedDescription(let text): return text
            
        case .badURL: return "Bad URL"
            
        case .jwtError: return "Decoding JWT Failed"
            
        case .somethingWentWrong: return "Internet Connection not Available!"
        
        case .jsonDecodingFailed: return "Something went wrong while processing your request."

        case .message(let message): return message ?? "Try again later"
            
        case .badStatusCode(statusCode: let statusCode):
            return "Bad Request with status code" + " \(statusCode)"
        }
    }
}
