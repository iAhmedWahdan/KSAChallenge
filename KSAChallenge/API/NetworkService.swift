//
//  NetworkService.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit

struct APIConstants {
    static var baseURL: String = "https://api.github.com/"
    
    static var apiUserURL: String = {
        return baseURL + "users/"
    }()
    
    static var apiRepoURL: String = {
        return baseURL + "orgs/"
    }()
    
    static var clientUrl: String = {
        return "?client_id=Iv1.d3a054b36b4269d1&client_secret=48b2106f58564fe5b5b4c5379d5cf83c57ea3494"
    }()
        
}

class NetworkService {
    static let shared = NetworkService()
    
    func getUsersList(for username: String, page: Int, completed: @escaping (Result<[Users], ResponseError>) -> Void ) {
        let serviceUrl = APIConstants.apiUserURL + "\(username)/followers?per_page=100&page=\(page)" + APIConstants.clientUrl
        
        guard let url = URL(string: serviceUrl) else {
            completed(.failure(.wrongUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.connectionNotAvailable))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unknownResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode([Users].self, from: data)
                completed(.success(users))
            } catch  {
                completed(.failure(.invalidData))
            }
    
        }
        task.resume()
    }
    
    func getUser(for username: String, completed: @escaping (Result<User, ResponseError>) -> Void ) {
        let serviceUrl = APIConstants.apiUserURL + "\(username)" + APIConstants.clientUrl
        
        guard let url = URL(string: serviceUrl) else {
            completed(.failure(.wrongUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.connectionNotAvailable))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unknownResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode(User.self, from: data)
                completed(.success(users))
            } catch  {
                completed(.failure(.invalidData))
            }
    
        }
        task.resume()
    }
}

extension NetworkService {
    
    func getRepositoriesList(for username: String, page: Int, completed: @escaping (Result<[Repositories], ResponseError>) -> Void ) {
        let serviceUrl = APIConstants.apiUserURL + "\(username)/repositories?per_page=100&page=\(page)" + APIConstants.clientUrl
        
        guard let url = URL(string: serviceUrl) else {
            completed(.failure(.wrongUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.connectionNotAvailable))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.unknownResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode([Repositories].self, from: data)
                completed(.success(users))
            } catch  {
                completed(.failure(.invalidData))
            }
    
        }
        task.resume()
    }
    
//    func getRepositoriesList(for username: String, page: Int, completed: @escaping (Result<[Repositories], ResponseError>) -> Void ) {
//        let serviceUrl = APIConstants.apiRepoURL + "\(username)/repos?per_page=100&page=\(page)" + APIConstants.clientUrl
//
//        guard let url = URL(string: serviceUrl) else {
//            completed(.failure(.wrongUsername))
//            return
//        }
//        
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//
//            if let _ = error {
//                completed(.failure(.connectionNotAvailable))
//                return
//            }
//
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.unknownResponse))
//                return
//            }
//
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                let users = try decoder.decode([Repositories].self, from: data)
//                completed(.success(users))
//            } catch  {
//                completed(.failure(.invalidData))
//            }
//
//        }
//        task.resume()
//    }
}

enum ResponseError: String, Error {

    case wrongUsername = "Wrong username, try another username"

    case unknownResponse = "Invalid server response"
    
    case invalidData = "invalid data received"

    case connectionNotAvailable = "Internet Connection not Available!"
}
