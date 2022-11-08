//
//  AlamoNetworking.swift
//  L3_NetworkingExample
//
//  Created by Ihor Malovanyi on 28.10.2022.
//

import Foundation
import Alamofire

class AlamoNetworking<T: Endpoint> {
    
    enum Result {
        case data(Data?)
        case error(Error)
    }
    
    private var host: String
    private var headers: [String : String]
    
    init(_ hostString: String, headers: [String : String] = [:]) {
        self.host = hostString
        self.headers = headers
    }
    
    func perform(_ method: HTTPMethod, _ endpoint: T, _ parameters: NetworkRequestBodyConvertible, completion: @escaping (Result) -> ()) {
        AF.request(composeRequest(host + "/\(endpoint.pathComponent)", parameters),
                   method: method,
                   parameters: parameters.parameters,
                   headers: HTTPHeaders(headers))
            .response { response in
                if let error = response.error {
                    completion(.error(error))
                } else {
                    completion(.data(response.data))
                }
            }
    }
    
    func perform(_ method: HTTPMethod, _ endpoint: T, _ endpointID: Int, _ parameters: NetworkRequestBodyConvertible, completion: @escaping (Result) -> ()) {
        let endpointPath = RecipesEndpoint.information.rawValue.replacingOccurrences(of: "ID", with: "\(endpointID)")
        AF.request(composeRequest(host + "/\(endpointPath)", parameters),
                   method: method,
                   parameters: parameters.parameters,
                   headers: HTTPHeaders(headers))
            .response { response in
                if let error = response.error {
                    completion(.error(error))
                } else {
                    completion(.data(response.data))
                }
            }
    }
    
    private func composeRequest(_ host: String,
                                _ parameters: NetworkRequestBodyConvertible) -> String {
        var urlComps = URLComponents(string: host)!
        urlComps.queryItems = parameters.queryItems
        return urlComps.url?.absoluteString ?? ""
    }
    
    
}
