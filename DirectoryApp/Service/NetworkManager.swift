//
//  NetworkManager.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import Foundation

struct Constants {
    static let baseURL = "https://61e947967bc0550017bc61bf.mockapi.io/api/v1"
}

enum APIError: Error {
    case failedTogeData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
}

extension NetworkManager: NetworkManagerProtocol {
    
    func getData<T>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Codable {
        guard let url = URL(string: url) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            do {
                let page = try JSONDecoder().decode(T.self, from: data)
                completion(.success(page))

            } catch {
                completion(.failure(NetworkError.dataFailure))
            }
        }

        task.resume()
    }
    
    func getRawData(url: URL?, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        
        guard let url = url else {
            completion(.failure(NetworkError.urlFailure))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.other(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataFailure))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
        
    }
}
