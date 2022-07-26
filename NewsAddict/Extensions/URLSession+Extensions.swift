//
//  URLSession+Extensions.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 26/07/22.
//

import Foundation

extension URLSession {
    enum CustomError: Error {
        case invalidUrl
        case invalidData
    }
    
    func request<T: Codable>(url: URLComponents?, expecting: T.Type, params: [String: String] = [:], completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        
        var newUrl = url
        newUrl.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        newUrl.queryItems?.append(URLQueryItem(name: "apiKey", value: API_KEY))
        newUrl.percentEncodedQuery = newUrl.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B")
        
        guard let request = newUrl.url else {
            print("URL is invalid")
            return
        }
        
        let task = dataTask(with: request) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(CustomError.invalidData))
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                print("Hasil decode json dari \(request)")
                print(result)
                completion(.success(result))
            }
            catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
}
