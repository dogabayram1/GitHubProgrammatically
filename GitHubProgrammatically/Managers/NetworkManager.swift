//
//  NetworkManager.swift
//  GitHubProgrammatically
//
//  Created by Doğa Bayram on 4.02.2022.
//

import Foundation
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com"
    
    let cache = NSCache<NSString,UIImage>()
    
    private init(){}
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower],GFError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func getUserInfo(for username: String, completed: @escaping (Result<User,GFError>) -> Void) {
        let endpoint = baseURL + "/users/\(username)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidData))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                decoder.dateDecodingStrategy = .iso8601
                let user = try decoder.decode(User.self, from: data)
                completed(.success(user))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    
    func downloadImage(from url: String, completed: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: url)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: url) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse,
                  response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                      completed(nil)
                      return
                  }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                completed(image)
            }
        }
        task.resume()
    }
}
