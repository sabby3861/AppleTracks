//
//  APIManager.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 19/12/2021.
//

import Foundation
import UIKit


protocol LFAPIServiceProtocol {
    var urlSession: URLSessionProtocol {get}
}

/// APIManager Protocol
protocol APIManagerProtocol {
    func getAlbumsInfo(payload: ATHTTPPayloadProtocol,completion: @escaping (Result<ATMusicResponse, Error>) -> Void)
}

/// Network status
enum ReachabilityStatus {
    case unknown
    case disconnected
    case connected
}

///  API manager class to handle the API calls
class APIManager: LFAPIServiceProtocol {
    /// URLSession used for query
    var urlSession: URLSessionProtocol
    /// Data Task
    private var task: URLSessionDataTask?
    // Reachability to check the internet
    private let reachabilityManager: NetworkReachabilityManager?
    private(set) var reachabilityStatus: ReachabilityStatus
    /**
     Init kit
     - Parameter urlSession: URLSession used for query
     */
    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
        self.reachabilityManager = NetworkReachabilityManager()
        self.reachabilityStatus = .unknown
        beginListeningNetworkReachability()
    }
    
    deinit {
        reachabilityManager?.stopListening()
    }
    
    /*
     Reachability
     
     - Start the reachability
     - To checek network status
     */
    private func beginListeningNetworkReachability() {
        reachabilityManager?.listener = { status in
            switch status {
            case .unknown: self.reachabilityStatus = .unknown
            case .notReachable:
                self.reachabilityStatus = .disconnected
                self.showErrorForNoNetwork()
            case .reachable(.ethernetOrWiFi), .reachable(.wwan): self.reachabilityStatus = .connected
            }
            
        }
        reachabilityManager?.startListening()
    }
    /*
     Show Alert message on no network connection
     */
    private func showErrorForNoNetwork()  {
        task?.suspend()
        DispatchQueue.main.async {
            ATAlertViewController.showAlert(withTitle: alertTitle, message: networkError)
        }
    }
    
    /**
     Init kit
     
     - Parameter key: void
     */
    public convenience init() {
        self.init(urlSession: URLSession.shared)
    }
    
    /**
     - Send API Request
     **/
    private func sendRequest<T: Codable>(payload: ATHTTPPayloadProtocol, completion: @escaping (Result<T, Error>) -> Void)  {
        
        if let requestURL = payload.url{
            var urlRequest = URLRequest(url: requestURL)
            guard let headers = payload.headers else {
                fatalError(errorMessage)
            }
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
            urlRequest.httpMethod = payload.type?.httpMethod()
            task = urlSession.dataTask(with: urlRequest) { data, response, error in
                guard let data = data else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                    return
                }
                let result: Result<T, Error>
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(DateFormatter.yyyyMMdd)
                    let response = try decoder.decode(T.self, from: data)
                    result = .success(response)
                } catch let error {
                    result = .failure(error)
                }
                
                DispatchQueue.main.async {
                    completion(result)
                }

            }
            task?.resume()
        }
    }
}


/**
 Extension for APIManager
 */
extension APIManager: APIManagerProtocol {
    /**
     Retrieve the Albums
     - Parameter id:  Payload protocol, containing payload data
     - Parameter completion: Result of api call
     */
    func getAlbumsInfo(payload: ATHTTPPayloadProtocol, completion: @escaping (Result<ATMusicResponse, Error>) -> Void){
        sendRequest(payload: payload,completion: completion)
    }
}

