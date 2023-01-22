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
        return baseURL + "users"
    }()
    
    static var apiRepoURL: String = {
        return baseURL + "repos"
    }()
    
    static var clientUrl: String = {
        return "?client_id=Iv1.d3a054b36b4269d1&client_secret=48b2106f58564fe5b5b4c5379d5cf83c57ea3494"
    }()
        
}

// MARK: - Users

class NetworkService {
    static let shared = NetworkService()
    
    func getUsersList(page: Int, completed: @escaping (Result<[Users], APIError>) -> Void ) {
        let serviceUrl = APIConstants.apiUserURL + "?per_page=100&page=\(page)" + APIConstants.clientUrl
        
        guard let url = URL(string: serviceUrl) else {
            completed(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.somethingWentWrong))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.badStatusCode(statusCode: 0)))
                return
            }

            guard let data = data else {
                completed(.failure(.jwtError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode([Users].self, from: data)
                completed(.success(users))
            } catch  {
                completed(.failure(.jsonDecodingFailed))
            }
    
        }
        task.resume()
    }
    
    func getUser(for username: String, completed: @escaping (Result<User, APIError>) -> Void ) {
        let serviceUrl = APIConstants.apiUserURL + "/\(username)" + APIConstants.clientUrl
        
        guard let url = URL(string: serviceUrl) else {
            completed(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.somethingWentWrong))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.badStatusCode(statusCode: 0)))
                return
            }

            guard let data = data else {
                completed(.failure(.jwtError))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode(User.self, from: data)
                completed(.success(users))
            } catch  {
                completed(.failure(.jsonDecodingFailed))
            }
    
        }
        task.resume()
    }
}

// MARK: - getRepositoriesList

extension NetworkService {
    
    func getRepositoriesList(for username: String, page: Int, completed: @escaping (Result<[Repositories], APIError>) -> Void ) {
        let serviceUrl = APIConstants.apiUserURL + "/\(username)/repos?per_page=100&page=\(page)" + APIConstants.clientUrl

        guard let url = URL(string: serviceUrl) else {
            completed(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.somethingWentWrong))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.badStatusCode(statusCode: 0)))
                return
            }

            guard let data = data else {
                completed(.failure(.jwtError))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode([Repositories].self, from: data)
                completed(.success(users))
            } catch  {
                completed(.failure(.jsonDecodingFailed))
            }

        }
        task.resume()
    }
}


// MARK: - ForksUsers

extension NetworkService {
    
    func getForksUsersList(for ownerRepo: String, page: Int, completed: @escaping (Result<[ForksUsers], APIError>) -> Void ) {
        let serviceUrl = APIConstants.apiRepoURL + "/\(ownerRepo)/forks?per_page=100&page=\(page)" + APIConstants.clientUrl

        guard let url = URL(string: serviceUrl) else {
            completed(.failure(.badURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error {
                completed(.failure(.somethingWentWrong))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.badStatusCode(statusCode: 0)))
                return
            }

            guard let data = data else {
                completed(.failure(.jwtError))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let users = try decoder.decode([ForksUsers].self, from: data)
                completed(.success(users))
            } catch  {
                completed(.failure(.jsonDecodingFailed))
            }

        }
        task.resume()
    }
}
