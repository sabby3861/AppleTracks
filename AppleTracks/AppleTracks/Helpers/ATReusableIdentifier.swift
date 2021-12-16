//
//  ATReusableIdentifier.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 16/12/2021.
//

import Foundation
/// Protocol to use resuse identifier
protocol ATReusableIdentifier: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ATReusableIdentifier {
    static var reuseIdentifier: String {
        return "\(self)"
    }
}
