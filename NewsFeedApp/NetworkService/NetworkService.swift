//
//  NetworkService.swift
//  NewsFeedApp
//
//  Created by Дмитрий Пономарев on 13.07.2023.
//

import Foundation
import UIKit

protocol NetworkerviceProtocol {
    func getCommentsFromCashe(completion: @escaping (Result<[Article]?, Error>)-> Void)
}

class NetworkService: NetworkerviceProtocol {
    
    func getCommentsFromCashe(completion: @escaping (Result<[Article]?, Error>)-> Void) {
        if let data = UserDefaults.standard.value(forKey: "news") as? Data {
            let dateFromCashe = try? PropertyListDecoder().decode(Array<Article>.self, from: data)
            completion(.success(dateFromCashe))
            return
        } else {
            let urlString = "https://newsapi.org/v2/everything?q=keyword&apiKey=9ea828d6da64493ea4347a3182af9dac&page=1&pageSize=20"
            guard let url = URL(string: urlString) else { return }
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                }
                guard let data = data else {return}
                
                do {
                    let obj = try JSONDecoder().decode(Comment.self, from: data)
                    completion(.success(obj.articles))
                    UserDefaults.standard.set(try? PropertyListEncoder().encode(obj.articles), forKey: "news")
                    
                } catch {
                    completion(.failure(error))
                    print (String(describing: error))
                }
            }.resume()
        }
    }
}
