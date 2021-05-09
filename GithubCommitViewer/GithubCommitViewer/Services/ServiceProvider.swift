//
//  ServiceProvider.swift
//  GithubCommitViewer
//
//  Created by Jaimin Patel on 2021-05-06.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(APIServiceError)
    case empty
}

enum APIServiceError: Error {
    case apiError
    case dataDecodeError
    case repoNotFound
}

class ServiceProvider<T: Service> {
    
    init() {}
    
    func load<U>(service: T, decodeType: U.Type, completion: @escaping (Result<U>) -> Void) where U: Decodable {
        makeAPICall(service.urlRequest) { result in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    let response = try decoder.decode(decodeType, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(.dataDecodeError))
                }
            case .failure(let error):
                completion(.failure(error))
            case .empty:
                completion(.empty)
            }
        }
    }
    
    private func makeAPICall(_ request: URLRequest, completion: @escaping (Result<Data>) -> Void) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            //Check if there is any error with the API
            if error != nil {
                completion(.failure(.apiError))
                return
            }

            //Check for response code specific error
            if let response = response as? HTTPURLResponse {
                if response.statusCode == 404 {
                    completion(.failure(.repoNotFound))
                    return
                }
            }
            
            //Check for data
            if let data = data {
                completion(.success(data))
                return
            } else {
                completion(.empty)
            }
        }.resume()
    }
}
