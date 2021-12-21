//
//  ATMusic.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 19/12/2021.
//

import Foundation
struct ATMusicResponse: Codable{
    let albums : [ATMusic]?
    
    enum CodingKeys: String, CodingKey {
        case albums = "results"
    }
}

struct ATMusic: Codable, ATResponseProtocol {
    var track: String?
    var name: String?
    var image: String?
    var price: Double
    var date: Date
    var duration: Int
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case track = "trackName"
        case name = "artistName"
        case image = "artworkUrl100"
        case price = "trackPrice"
        case date = "releaseDate"
        case duration = "trackTimeMillis"
        case url = "trackViewUrl"
    }
}

protocol ATResponseProtocol {
    var track: String? {get set}
    var price: Double {get set}
    var name: String? {get set}
    var image: String? {get set}
    var date: Date {get set}
    var duration: Int {get set}
    var url: String? {get set}
}
