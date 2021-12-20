//
//  ATDateFormatter.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 20/12/2021.
//

import Foundation

// Extension for formatting the date 
extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return formatter
    }()
}
