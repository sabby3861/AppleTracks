//
//  ATPayload.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 19/12/2021.
//

import Foundation
protocol PayLoadFormat {
    func formatGetPayload(url: ATHTTPUrl, module: ATAPIModule) -> ATHTTPPayloadProtocol
}
extension PayLoadFormat{
    func formatGetPayload(url: ATHTTPUrl, module: ATAPIModule) -> ATHTTPPayloadProtocol{
        var payload = ATHTTPPayload(url: url,payload: module)
        payload.headers = Dictionary<String, String>()
        payload.addHeader(name: ATHTTPHeaderType.contentType.rawValue, value: ATHTTPMimeType.applicationJSON.rawValue)
        return payload
    }
}

protocol ATHTTPPayloadProtocol {
    var type: ATHTTPPayloadType? { get }
    var headers: Dictionary<String, String>? { get set }
    var url: URL? {get}
}
/// Payload
struct ATHTTPPayload: ATHTTPPayloadProtocol {
    var type: ATHTTPPayloadType?
    var headers: Dictionary<String, String>?
    var url: URL?
    let apiKey = "aa8e1202264ab46b248d9583c0cda190"
    fileprivate init(url: ATHTTPUrl, payload: ATAPIModule) {
        self.type = payload.payloadType
        var components = URLComponents()
            components.scheme = "https"
            components.host = url.rawValue
            components.path = "/search"
            components.queryItems = [
                URLQueryItem(name: "term", value: "jazz"),
                URLQueryItem(name: "media", value: "music")
            ]
        self.url = components.url
    }
    fileprivate mutating func addHeader(name: String, value: String) {
        headers?[name] = value
    }
}

enum ATHTTPMimeType: String {
    case applicationJSON = "application/json; charset=utf-8"
}
enum ATHTTPHeaderType: String{
    case contentType    = "Content-Type"
}

enum ATHTTPMethod: String {
    case get
    case put
}

enum ATHTTPPayloadType{
    case requestMethodGET
    case requestMethodPUT
    func httpMethod() -> String {
        switch self{
        case .requestMethodGET: return ATHTTPMethod.get.rawValue
        case .requestMethodPUT: return ATHTTPMethod.put.rawValue
        }
    }
    
}

enum ATHTTPUrl: String {
    case albumsUrl = "itunes.apple.com"
}


struct ATAPIModule {
    var payloadType: ATHTTPPayloadType?    
}


enum ATSearchType: String {
  case album = "album.search"
  case song = "track.search"
  case artist = "artist.search"
}
