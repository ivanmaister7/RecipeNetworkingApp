//
//  Networking.swift
//  L3_NetworkingExample
//
//  Created by Ihor Malovanyi on 28.10.2022.
//

import Foundation

protocol Endpoint {
    
    var pathComponent: String { get }
    
}

enum RecipesEndpoint: String, Endpoint {
    
    case analyzer = "recipes/analyzeInstructions"
    case search = "recipes/complexSearch"
    case information = "recipes/ID/information"
    case guess = "recipes/guessNutrition"
    case classify = "recipes/cuisine"
    
    var pathComponent: String {
        rawValue
    }
    
}

struct RecipeInfoEndpoint: Endpoint {
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var pathComponent: String {
        "recipes/\(self.id)/information"
    }
    
}

final class Network<T: Endpoint> {
    
    enum Result {
        
        case data(Data?)
        case error(Error)
        
    }
    
    enum NetworkError: Error {
        
        case badHostString
        
    }
    
    enum Method: String {
        
        case get = "GET"
        case post = "POST"
        case delete = "DELETE"
        case put = "PUT"
        case patch = "PATCH"
        
    }
    
    private var host: URL
    private var headers: [String : String]
    private var session = URLSession.shared
    
    init(_ hostString: String, headers: [String : String] = [:]) throws {
        if let url = URL(string: hostString) {
            self.host = url
            self.headers = headers
            
            return
        }
        
        throw NetworkError.badHostString
    }
    
    private func append(url: URL?, queryItems: [URLQueryItem]) -> URL{
        var urlComps = URLComponents(string: url?.absoluteString ?? "")!
        urlComps.queryItems = queryItems
        return urlComps.url!
    }
    
    private func makeRequest(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible?) -> URLRequest {
        
        
        
        var request = URLRequest(url: host.appendingPathComponent(endpoint.pathComponent))
        
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        if method == .get {
            print(request)
            request.url = append(url: request.url, queryItems: parameters?.queryItems ?? [])
            print(request)
        } else if method == .post {
            request.httpBody = parameters?.data
        }
        
        return request
    }
    
    func perform(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible? = nil, completion: @escaping (Result) -> ()) {
        let request = makeRequest(method, endpoint, parameters)
        
        session.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.error(error))
            } else {
                completion(.data(data))
            }
        }.resume()
    }
    
//    func perform(_ method: Method, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible? = nil) async throws -> Data {
//        let request = makeRequest(method, endpoint, parameters)
//        let (data, _) = try await session.data(for: request)
//        return data
//    }
    
}












