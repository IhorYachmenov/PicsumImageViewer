//
//  NetworkClient.swift
//  NetworkLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

public final class NetworkClient {
    public init() {
        
    }
    
    public func downloadImages(url: String, completion: @escaping (Result<[NetworkModel.Image], Error>) ->()) {
        if let url = URL(string: url) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError.error(msg: "No Data")))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model = try decoder.decode([NetworkModel.Image].self, from: data)
                    
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        } else {
            completion(.failure(NSError.error(msg: "Invalid URL")))
        }
    }
}
