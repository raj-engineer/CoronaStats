//
//  NetworkService.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 11/01/23.
//

import Foundation

typealias CompletionHandler<T: Decodable> = (Result<T, Error>) -> Void

protocol NetworkServiceProtocol {
    func execute<T: Decodable>(networkConfig: NetworkConfigurable, completion: @escaping CompletionHandler<T>)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let requestGenerator: NeworkRequestProtocol
    
    init(session: URLSession, requestGenerator: NeworkRequestProtocol) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    convenience init(session: URLSession = .shared) {
        self.init(session: session, requestGenerator: NeworkRequest())
    }
    
    func execute<T: Decodable>(networkConfig: NetworkConfigurable, completion: @escaping CompletionHandler<T>) {
        
        guard let urlRequest = try? requestGenerator.createURLRequest(with: networkConfig) else {
            return completion(.failure(NetworkError.invalidRequest))
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in

            if let _ = error {
                return completion(.failure(NetworkError.badRequest))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.noResponse))
            }
            
            if urlResponse.statusCode != 200 {
                return completion(.failure(NetworkError.failed))
            }
            
            guard let data = data else {
                return completion(.failure(NetworkError.noData))
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.unableToDecode))
            }
        }
        task.resume()
    }
}
