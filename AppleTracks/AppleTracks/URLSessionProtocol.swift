//
//  URLSessionProtocol.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 16/12/2021.
//

import Foundation
/// Alias for the Closure
typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void

/// Protocol defining the data task operation for URLSession
protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
